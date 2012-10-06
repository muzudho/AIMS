--Sorry, Encoding of this file is Shift-JIS.

--【改変】このファイルは新規に追加。

--ファイル作成    ：2012-10-07 鬼畜大王
--ファイル編集最終：2012-10-07 鬼畜大王

--[[
	使い方。

	（１）Luaファイルを読み込んでおきます。
		prequire("s/csv.lua");
		prequire("s/auto.lua");
		--その他、シーンファイル。

	（２）シーン遷移CSVを作成します。

		data/sceneChanges.csv

		（例）
		NO,SCENE,Expl,BTN1,BTN2,BTN3,BTN4,BTN5,BTN6,BTN7,BTN8,BTN9,BTN10,BTN11,BTN12,END
		int,int,string,int,int,int,int,int,int,int,int,int,int,int,int,END
		-1,シーン名。空白または「-1」を入れると無視されます。,解説,ボタン1を押したときの移動先シーン名。空白または「-1」を入れると無視されます。,ボタン2,ボタン3,ボタン4,ボタン5,ボタン6,ボタン7,ボタン8,ボタン9,ボタン10,ボタン11,ボタン12,END
		-1,,"Sorry, Encoding of this csv file is Shift-JIS.（このCSVファイルはShift-JISエンコーディングです。）",,,,,,,,,,,,,END
		0,scene1,,,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		1,scene2,,scene1,,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		2,scene3,,scene1,scene2,,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		3,scene4,,scene1,scene2,scene3,,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		4,scene5,,scene1,scene2,scene3,scene4,,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		5,scene6,,scene1,scene2,scene3,scene4,scene5,,scene7,scene8,scene9,scene10,scene11,scene12,END
		6,scene7,,scene1,scene2,scene3,scene4,scene5,scene6,,scene8,scene9,scene10,scene11,scene12,END
		7,scene8,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,,scene9,scene10,scene11,scene12,END
		8,scene9,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,,scene10,scene11,scene12,END
		9,scene10,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,,scene11,scene12,END
		10,scene11,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,,scene12,END
		11,scene12,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,,END
		EOF,,,,,,,,,,,,,,,

	（３）シーンの _OnStep の最後で、次の関数を呼び出します。

		auto_ForwardScene("scene1");	--引数は自シーン名。

	これで、押したボタンに応じて changeScene します。
	以上。
]]


--外部ファイルと照らし合わせて、シーン移動します。
--current_NameScene:自シーン名。空白または「-1」は入れないでください。
function auto_ForwardScene(current_NameScene)


	--データベース・テーブル
	local t = csv_FromFile("data/sceneChanges.csv")

	--レコード
	local hitsRecord
	local rowNum = 1
	for number_Row,record in pairs(t) do
		if 4<=rowNum then
			if record["SCENE"]==current_NameScene then
				hitsRecord = record
				break
			end
		end
		
		rowNum = rowNum + 1
	end

	-- ゲームパッドの、十字キー以外のボタンを受け付けます。
	local next_NameScene = ""
	if(isJoyPressed(BUTTON_TRIG1))then
		-- ゲームパッドのボタン1が今押されている
		next_NameScene = hitsRecord["BTN1"];
	end

	if(isJoyPressed(BUTTON_TRIG2))then
		-- ゲームパッドのボタン2が今押されている
		next_NameScene = hitsRecord["BTN2"];
	end

	if(isJoyPressed(BUTTON_TRIG3))then
		-- ゲームパッドのボタン3が今押されている
		next_NameScene = hitsRecord["BTN3"];
	end

	if(isJoyPressed(BUTTON_TRIG4))then
		-- ゲームパッドのボタン4が今押されている
		next_NameScene = hitsRecord["BTN4"];
	end

	if(isJoyPressed(BUTTON_TRIG5))then
		-- ゲームパッドのボタン5が今押されている
		next_NameScene = hitsRecord["BTN5"];
	end

	if(isJoyPressed(BUTTON_TRIG6))then
		-- ゲームパッドのボタン6が今押されている
		next_NameScene = hitsRecord["BTN6"];
	end

	if(isJoyPressed(BUTTON_TRIG7))then
		-- ゲームパッドのボタン7が今押されている
		next_NameScene = hitsRecord["BTN7"];
	end

	if(isJoyPressed(BUTTON_TRIG8))then
		-- ゲームパッドのボタン8が今押されている
		next_NameScene = hitsRecord["BTN8"];
	end

	if(isJoyPressed(BUTTON_TRIG9))then
		-- ゲームパッドのボタン9が今押されている
		next_NameScene = hitsRecord["BTN9"];
	end

	if(isJoyPressed(BUTTON_TRIG10))then
		-- ゲームパッドのボタン10が今押されている
		next_NameScene = hitsRecord["BTN10"];
	end

	if(isJoyPressed(BUTTON_TRIG11))then
		-- ゲームパッドのボタン11が今押されている
		next_NameScene = hitsRecord["BTN11"];
	end

	if(isJoyPressed(BUTTON_TRIG12))then
		-- ゲームパッドのボタン12が今押されている
		next_NameScene = hitsRecord["BTN12"];
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
