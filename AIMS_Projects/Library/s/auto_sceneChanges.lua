--Sorry, Encoding of this file is Shift-JIS.

--【改変】このファイルは新規に追加。

--『鬼畜大王のAIMS/Luaライブラリー』
--Copyright (c) 2012, 鬼畜大王
--All rights reserved.
--ファイル作成    ：2012-10-07 鬼畜大王
--ファイル編集最終：2012-10-14 鬼畜大王

--[[
	使い方。

	（１）Luaファイルを読み込んでおきます。
		prequire("s/csv.lua");
		prequire("s/auto_sceneChanges.lua");
		--その他、シーンファイル。

	（２）シーン遷移CSVを作成します。

		data/auto_sceneChanges.csv

		（例）
		NO,ID,Expl,ALWAYS,DISABLED_AT_LOADING,THREAD_NOT_RUNNING,BTN1,BTN1_PARAM,BTN2,BTN2_PARAM,BTN3,BTN3_PARAM,BTN4,BTN4_PARAM,BTN5,BTN5_PARAM,BTN6,BTN6_PARAM,BTN7,BTN7_PARAM,BTN8,BTN8_PARAM,BTN9,BTN_PARAM,BTN10,BTN10_PARAM,BTN11,BTN11_PARAM,BTN12,BTN12_PARAM,END
		int,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,END
		-1,auto_SceneAt(...)が置かれている関数名を入れると便利です。識別できれば何でも構わない。空白または「-1」を入れると無視されます。,解説,この列に設定されていると、必ずこれが選ばれます。,「Yes」…isLoaderRunning=true （データロード中）の場合、ボタン入力によるシーン遷移を無効にします。「No、-1、(空白)」…なにもしません。,isThreadRunning()==false（スレッドが終了している）の場合、ボタンよりも優先的にこれが選ばれます。（空白、または-1以外が設定されている場合）,ボタン1を押したときの移動先シーン名。空白または「-1」を入れると無視されます。,「Push」…一度ボタンを離してから押さないと反応しません。「(空白)または-1」…押していれば反応します。,ボタン2,ボタン2,ボタン3,ボタン3,ボタン4,ボタン4,ボタン5,ボタン5,ボタン6,ボタン6,ボタン7,ボタン7,ボタン8,ボタン8,ボタン9,ボタン9,ボタン10,ボタン10,ボタン11,ボタン11,ボタン12,ボタン12,END
		-1,,"Sorry, Encoding of this csv file is Shift-JIS.（このCSVファイルはShift-JISエンコーディングです。）",,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		0,boot_OnStart,,logo,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		1,logo_OnStep(DONT_USE),CSVファイルが読込み完了していないことがあるので、このレコードは使えない。,,Yes,title,title,,,,,,,,,,,,,,,,,,,,,,,,END
		2,title_OnStep,,,,,game,Push,,,,,,,,,,,,,,,,,,,,,,,END
		3,thread_gameover,,gameover,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		4,gameover_OnStep,,,,,title,,,,,,,,,,,,,,,,,,,,,,,,END
		EOF,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

	（３）シーンを切り替えたいタイミングで、次の関数を呼び出します。

		auto_SceneAt("scene1_OnStep");	--引数は、これを呼び出している関数の名前を入れると便利。

	これで、押したボタンに応じて changeScene します。
	以上。
]]


--外部ファイルと照らし合わせて、シーン移動します。
--id:この関数を置いている関数の名前を入れると便利です。空白または「-1」は入れないでください。
function auto_SceneAt(id)


	--データベース・テーブル
	local t = csv_FromFile("data/auto_sceneChanges.csv")

	--レコード
	local hitsRecord
	local rowNum = 1
	for number_Row,record in pairs(t) do
		if 4<=rowNum then
			if record["ID"]==id then
				hitsRecord = record
				break
			end
		end
		
		rowNum = rowNum + 1
	end

	-- ゲームパッドの、十字キー以外のボタンを受け付けます。
	local next_NameScene
	next_NameScene = hitsRecord["ALWAYS"];
	if("-1"==next_NameScene)then
		--空白および「-1」は空白扱い（入力を無かったことに）。
		next_NameScene = ""
	end

	if(""==next_NameScene and isLoaderRunning())then
		--データロード中のとき。
		next_NameScene = hitsRecord["DISABLED_AT_LOADING"];
		if("Yes"==next_NameScene)then
			--ボタン押下による画面遷移を無視します。
			next_NameScene = "-1"
		end
	end

	if(""==next_NameScene and isThreadRunning()==false)then
		--スレッドが走っていないとき。
		next_NameScene = hitsRecord["THREAD_NOT_RUNNING"];
		if("-1"==next_NameScene)then
			--空白および「-1」は空白扱い（入力を無かったことに）。
			next_NameScene = ""
		end
	end

	local button_trig = {
		BUTTON_TRIG1,
		BUTTON_TRIG2,
		BUTTON_TRIG3,
		BUTTON_TRIG4,
		BUTTON_TRIG5,
		BUTTON_TRIG6,
		BUTTON_TRIG7,
		BUTTON_TRIG8,
		BUTTON_TRIG9,
		BUTTON_TRIG10,
		BUTTON_TRIG11,
		BUTTON_TRIG12
	}
	local btnParam, hits
	local btnNum=1
	--ボタン1～12。
	while(""==next_NameScene and btnNum<=12)do

		-- BTN1_PARAM ～ BTN12_PARAM
		btnParam = hitsRecord[ "BTN" .. btnNum .. "_PARAM" ];
		if( btnParam=="Push" )then
			if( 1==getJoyPressCount(0,button_trig[btnNum]) )then
				-- ゲームパッドのボタンNが、いったん離された後に押された時。
				hits = true
			end
		elseif( 0<getJoyPressCount(0,button_trig[btnNum]) )then
			-- ゲームパッドのボタンNは、今押されている。
			hits = true
		end
		if( hits )then
			-- BTN1 ～ BTN12
			next_NameScene = hitsRecord[ "BTN" .. btnNum ];
			break;
		end

		btnNum = btnNum + 1
	end

	--ゲームパッドのボタンの定数は BUTTON_TRIG1～BUTTON_TRIG12 （１２個）までしか存在しない。


	--CSVから読み取った値は、数字であっても、文字列型になっています。

	--シーン番号は、空白、または「-1」を無視します。
	if( "" ~= next_NameScene and "-1" ~= next_NameScene )then
		--文字列連結してシーン名を作成します。
		changeScene(next_NameScene) -- シーン切替。
	end

end

--【/改変】このファイルは新規に追加。
