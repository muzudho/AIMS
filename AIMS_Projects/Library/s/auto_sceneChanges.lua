--Sorry, Encoding of this file is Shift-JIS.

--【改変】このファイルは新規に追加。

--『鬼畜大王のAIMS/Luaライブラリー』
--Copyright (c) 2012, 鬼畜大王
--All rights reserved.
--ファイル作成    ：2012-10-07 鬼畜大王
--ファイル編集最終：2012-10-27 鬼畜大王
--
--使い方、およびトラブルシューティングは、GitHubの同フォルダー内にある
--How_to_use(auto_sceneChanges_lua).txt を読んでください。


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

	if( nil==hitsRecord)then
		--記述がない場合は無視。
	else
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
end

--【/改変】このファイルは新規に追加。
