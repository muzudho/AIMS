function lose_OnStart ()
	-- 1.まず画像を読み込む
	G.background   = loadGraphic("gfx/Bg_lose.png");

	-- 2.アクターを表示する。
	A.background   = createActor(G.background, 640/2, 480/2, 11);
end

function lose_OnStep ()
    if( 1 == getJoyPressCount( BUTTON_DOWN ) ) then
    	--下ボタン
    	changeScene("talk")
    end
end

function lose_OnClose ()
	-- 3.表示した画像を消去する
	vanish(A.background);

	-- 4.画像を開放する
	deleteGraphic(G.background);
end
