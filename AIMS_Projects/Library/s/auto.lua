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
		-1,シーン番号,解説,ボタン1,ボタン2,ボタン3,ボタン4,ボタン5,ボタン6,ボタン7,ボタン8,ボタン9,ボタン10,ボタン11,ボタン12,END
		0,1,,-1,2,3,4,5,6,7,8,9,10,11,12,END
		,2,,1,-1,3,4,5,6,7,8,9,10,11,12,END
		,3,,1,2,-1,4,5,6,7,8,9,10,11,12,END
		,4,,1,2,3,-1,5,6,7,8,9,10,11,12,END
		,5,,1,2,3,4,-1,6,7,8,9,10,11,12,END
		,6,,1,2,3,4,5,-1,7,8,9,10,11,12,END
		,7,,1,2,3,4,5,6,-1,8,9,10,11,12,END
		,8,,1,2,3,4,5,6,7,-1,9,10,11,12,END
		,9,,1,2,3,4,5,6,7,8,-1,10,11,12,END
		,10,,1,2,3,4,5,6,7,8,9,-1,11,12,END
		,11,,1,2,3,4,5,6,7,8,9,10,-1,12,END
		,12,,1,2,3,4,5,6,7,8,9,10,11,-1,END
		EOF,,,,,,,,,,,,,,,

	（３）シーンの _OnStep の最後で、次の関数を呼び出します。

		auto_ForwardScene(1);	--引数は自シーン番号。

	これで、押したボタンに応じて changeScene します。
	（シーン名は数字とします）
	以上。
]]

function auto_ForwardScene(currentScene)


	--データベース・テーブル
	local t = csv_FromFile("data/sceneChanges.csv")

	--レコード
	local hitsRecord
	local rowNum = 1
	for number_Row,record in pairs(t) do
		if 4<=rowNum then
			if tonumber(record["SCENE"])==currentScene then
				hitsRecord = record
				break
			end
		end
		
		rowNum = rowNum + 1
	end

	-- ゲームパッドの、十字キー以外のボタンを受け付けます。
	local nextScene = -1
	if(isJoyPressed(BUTTON_TRIG1))then
		-- ゲームパッドのボタン1が今押されている
		nextScene = hitsRecord["BTN1"];
	end

	if(isJoyPressed(BUTTON_TRIG2))then
		-- ゲームパッドのボタン2が今押されている
		nextScene = hitsRecord["BTN2"];
	end

	if(isJoyPressed(BUTTON_TRIG3))then
		-- ゲームパッドのボタン3が今押されている
		nextScene = hitsRecord["BTN3"];
	end

	if(isJoyPressed(BUTTON_TRIG4))then
		-- ゲームパッドのボタン4が今押されている
		nextScene = hitsRecord["BTN4"];
	end

	if(isJoyPressed(BUTTON_TRIG5))then
		-- ゲームパッドのボタン5が今押されている
		nextScene = hitsRecord["BTN5"];
	end

	if(isJoyPressed(BUTTON_TRIG6))then
		-- ゲームパッドのボタン6が今押されている
		nextScene = hitsRecord["BTN6"];
	end

	if(isJoyPressed(BUTTON_TRIG7))then
		-- ゲームパッドのボタン7が今押されている
		nextScene = hitsRecord["BTN7"];
	end

	if(isJoyPressed(BUTTON_TRIG8))then
		-- ゲームパッドのボタン8が今押されている
		nextScene = hitsRecord["BTN8"];
	end

	if(isJoyPressed(BUTTON_TRIG9))then
		-- ゲームパッドのボタン9が今押されている
		nextScene = hitsRecord["BTN9"];
	end

	if(isJoyPressed(BUTTON_TRIG10))then
		-- ゲームパッドのボタン10が今押されている
		nextScene = hitsRecord["BTN10"];
	end

	if(isJoyPressed(BUTTON_TRIG11))then
		-- ゲームパッドのボタン11が今押されている
		nextScene = hitsRecord["BTN11"];
	end

	if(isJoyPressed(BUTTON_TRIG12))then
		-- ゲームパッドのボタン12が今押されている
		nextScene = hitsRecord["BTN12"];
	end

	--ゲームパッドのボタンの定数は BUTTON_TRIG1～BUTTON_TRIG12 （１２個）までしか存在しない。


	nextScene = tonumber(nextScene)

	--シーン番号は、0以下を無視します。
	if(1<=nextScene)then
		--文字列連結してシーン名を作成します。
		changeScene("scene" .. nextScene) -- シーン切替。
	end

end

--【/改変】このファイルは新規に追加。
