function talk_OnStart ()
	-- 1.まず画像を読み込む
	G.background   = loadGraphic("gfx/Bg_talk.png");

	-- 2.アクターを表示する。
	A.background   = createActor(G.background, 640/2, 480/2, 11);
end

function talk_OnStep ()

	--最終ステージクリアー？
    if( 1 == getJoyPressCount( BUTTON_RIGHT ) ) then
    	--右ボタン（ＮＯ）
    	changeScene("stgsel")
    end

    if( 1 == getJoyPressCount( BUTTON_DOWN ) ) then
    	--下ボタン（ＹＥＳ）
    	changeScene("ending")
    end
end

function talk_OnClose ()
	-- 3.表示した画像を消去する
	vanish(A.background);

	-- 4.画像を開放する
	deleteGraphic(G.background);
end
