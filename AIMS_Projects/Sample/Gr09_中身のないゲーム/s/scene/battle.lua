function battle_OnStart ()
	-- 1.まず画像を読み込む
	G.background   = loadGraphic("gfx/Bg_battle.png");

	-- 2.アクターを表示する。
	A.background   = createActor(G.background, 640/2, 480/2, 11);
end

function battle_OnStep ()
    if( 1 == getJoyPressCount( BUTTON_RIGHT ) ) then
    	--右ボタン（マップを開いた）
    	changeScene("map")
    end
    
    if( 1 == getJoyPressCount( BUTTON_DOWN ) ) then
    	--下ボタン（負け）
    	changeScene("lose")
    end
	
    if( 1 == getJoyPressCount( BUTTON_LEFT ) ) then
    	--左ボタン（勝ち）
    	changeScene("win")
    end
    
    if( 1 == getJoyPressCount( BUTTON_UP ) ) then
    	--上ボタン（メニューを開いた）
    	changeScene("menu")
    end
end

function battle_OnClose ()
	-- 3.表示した画像を消去する
	vanish(A.background);

	-- 4.画像を開放する
	deleteGraphic(G.background);
end
