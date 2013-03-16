function stgsel_OnStart ()
	-- 1.まず画像を読み込む
	G.background   = loadGraphic("gfx/Bg_stgsel.png");

	-- 2.アクターを表示する。
	A.background   = createActor(G.background, 640/2, 480/2, 11);
end

function stgsel_OnStep ()
    if( 1 == getJoyPressCount( BUTTON_DOWN ) ) then
    	--下ボタン
    	changeScene("chrsel")
    end
end

function stgsel_OnClose ()
	-- 3.表示した画像を消去する
	vanish(A.background);

	-- 4.画像を開放する
	deleteGraphic(G.background);
end
