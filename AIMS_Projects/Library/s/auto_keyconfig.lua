--Sorry, Encoding of this file is Shift-JIS.

-- 【改変】このファイルは新規に追加。

--『鬼畜大王のAIMS/Luaライブラリー』
--Copyright (c) 2012, 鬼畜大王
--All rights reserved.
--ファイル作成    ：2012-10-28 鬼畜大王
--ファイル編集最終：2012-10-28 鬼畜大王
--
--使い方、およびトラブルシューティングは、GitHubの同フォルダー内にある
--How_to_use(auto_keyconfig_lua).txt を読んでください。


KEYCONFIG_state = 0 --状態0「Ａを決めてください」からスタート。
KEYCONFIG_physicalButtons = {
	-1;
	-1;
	-1;
	-1;
	-1;
	-1;
	-1;
	-1;
} --ボタン番号。
KEYCONFIG_filename = "keyconfig.csv" --読み書きされるファイル名。


function sceneKeyconfig_OnStart()
	-- まず画像を読み込む
	G.bg     =     loadGraphic("gfx/sceneKeyconfig.png"); -- シーン背景画像読込み。
	G.font   = createAsciiFont("gfx/font16.png", 16, 16);

	-- アクターを表示する。
	-- createActor(グラフィックハンドル, X座標, Y座標, レイヤー番号);
	A.buttons  = { }
	A.messages = { }
	A.bg = createActor(G.bg, 320, 240,0);

end


function sceneKeyconfig_OnStep()

	--状態0「Ａを決めてください」
	--状態1「Ｂを決めてください」
	--状態2「Ｘを決めてください」
	--状態3「Ｙを決めてください」
	--状態4「Ｌを決めてください」
	--状態5「Ｒを決めてください」
	--状態6「Ｓを決めてください」
	--状態7「Ｐを決めてください」
	if( KEYCONFIG_state<=7 )then
		auto_KeyconfigPleasePushButton()

	elseif( 8==KEYCONFIG_state )then
	--状態8「設定を保存します」
		auto_KeyconfigWrite();

	elseif( 9==KEYCONFIG_state )then
	--状態9「ウィンドウを閉じてください」
	
		local messages = {
			"ｾｯﾃｲ ｶﾝﾘｮｳ!";
			KEYCONFIG_filename.." ﾆ ﾎｿﾞﾝ ｼﾏｼﾀ｡";
			"ﾅﾆｶ ﾎﾞﾀﾝｦ ｵｽﾄ､ ｳｨﾝﾄﾞｳｦ ﾄｼﾞﾏｽ｡";
		}
		
		for i=1,#messages do
			--座標位置は画面を見ながら修正。
			A.messages[i] = createTextActor(G.font, messages[i], 320-string.len(messages[i])*16/2, (i-1)*32+336, 10 );
		end

		KEYCONFIG_state = KEYCONFIG_state + 1

	elseif( 10==KEYCONFIG_state )then
	--状態10「何かボタンを押すとウィンドウを閉じます」

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
		--ボタン1〜12。
		local hits = false
		for btnNum=1,12 do

			if( 1==getJoyPressCount( 0, button_trig[btnNum]) )then
				-- ゲームパッドのボタンNが、いったん離された後に押された時。
				hits = true
				break
			end
		end

		if( hits )then
			quit()
		end
	end

	auto_SceneAt("sceneKeyconfig_OnStep");
end


function sceneKeyconfig_OnClose()
	-- 表示した画像を消去する
	vanish(A.buttons);
	vanish(A.messages);
	vanish(A.bg);

	-- 画像を開放する
	deleteGraphic(G.bg);
	deleteGraphic(G.font);

	cls(); -- シーン内の全アクターを消去します。
end


--設定を保存します。
function auto_KeyconfigWrite()
	
	out = io.open( KEYCONFIG_filename, "w")

	out:write( "NO,Expl,PLAYER,A,B,X,Y,L,R,S,P,END\n" )
	out:write( "int,string,int,int,int,int,int,int,int,int,int,END\n" )
	out:write( "-1,解説,プレイヤー番号1〜,Aボタン物理番号,Bボタン物理番号,Xボタン物理番号,Yボタン物理番号,Lボタン物理番号,Rボタン物理番号,Selectボタン物理番号,Pauseボタン物理番号,END\n" )
	out:write( "-1,\"Sorry, Encoding of this csv file is Shift-JIS.（このCSVファイルはShift-JISエンコーディングです。）\",,,,,,,,,,END\n" )
	out:write( "0,\"1プレイヤー\",1,".. KEYCONFIG_physicalButtons[1] ..",".. KEYCONFIG_physicalButtons[2] ..",".. KEYCONFIG_physicalButtons[3] ..",".. KEYCONFIG_physicalButtons[4] ..",".. KEYCONFIG_physicalButtons[5] ..",".. KEYCONFIG_physicalButtons[6] ..",".. KEYCONFIG_physicalButtons[7] ..",".. KEYCONFIG_physicalButtons[8] ..",END\n" )
	out:write( "EOF" )

	out:close()
	
	KEYCONFIG_state = KEYCONFIG_state + 1
end


--設定を読み込みます。
function auto_KeyconfigRead()

	local csvTable = csv_FromFile( KEYCONFIG_filename );

	local hitsRecord
	hitsRecord = csv_SelectRecord( csvTable, "PLAYER", "1" )

	if( nil~=hitsRecord )then

		--デフォルトのボタン定数は common.lua に記述されています。
		--0〜3は、右下左上。

		local physicalButton
		
		--論理ボタン1をAボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["A"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG1, physicalButton );
			--debugOut( "Aボタン(".. BUTTON_TRIG1 ..") = [".. physicalButton .."]" )
		end

		--論理ボタン2をBボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["B"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG2, physicalButton );
			--debugOut( "Bボタン(".. BUTTON_TRIG2 ..") = [".. physicalButton .."]" )
		end

		--論理ボタン3をXボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["X"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG3, physicalButton );
			--debugOut( "Xボタン(".. BUTTON_TRIG3 ..") = [".. physicalButton .."]" )
		end

		--論理ボタン4をYボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["Y"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG4, physicalButton );
			--debugOut( "Yボタン(".. BUTTON_TRIG4 ..") = [".. physicalButton .."]" )
		end

		--論理ボタン5をLボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["L"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG5, physicalButton );
			--debugOut( "Lボタン(".. BUTTON_TRIG5 ..") = [".. physicalButton .."]" )
		end

		--論理ボタン6をRボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["R"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG6, physicalButton );
			--debugOut( "Rボタン(".. BUTTON_TRIG6 ..") = [".. physicalButton .."]" )
		end

		--論理ボタン7をSボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["S"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG7, physicalButton );
			--debugOut( "Sボタン(".. BUTTON_TRIG7 ..") = [".. physicalButton .."]" )
		end

		--論理ボタン8をPボタンと呼ぶとします。
		physicalButton = tonumber( hitsRecord["P"])
		if( nil~=physicalButton and 0<=physicalButton )then
			setJoyBind( 0, BUTTON_TRIG8, physicalButton );
			--debugOut( "Pボタン(".. BUTTON_TRIG8 ..") = [".. physicalButton .."]" )
		end

	else
		debugOut( "キーコンフィグ設定ファイルからは、１プレイヤーの設定を読み込めませんでした。" )

	end
end


function auto_KeyconfigPleasePushButton()

	local hitsPhysicalButton = -1 --物理ボタン番号。押されていなければ負数。

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

	local btnNum=1
	--ボタン1〜12。
	for btnNum=1,12 do

		if( 1==getJoyPressCount( 0, button_trig[btnNum]) )then
			-- ゲームパッドのボタンNが、いったん離された後に押された時。
			
			-- 現在押されているボタンの物理番号を取得する。同時に押されている場合は、一番若い番号。
			hitsPhysicalButton = getJoyPhysicalButton()
			break
		end
	end


	
	if( 0 <= hitsPhysicalButton )then
		--決まった。
		KEYCONFIG_physicalButtons[KEYCONFIG_state+1] = hitsPhysicalButton
		--16x16サイズ・フォントの位置を -8 調整する。
		A.buttons[KEYCONFIG_state+1] = createTextActor(G.font, tostring(hitsPhysicalButton), KEYCONFIG_state*64+103-8, 239-8, 10 );
		KEYCONFIG_state = KEYCONFIG_state + 1
	end
end


-- 【/改変】このファイルは新規に追加。
