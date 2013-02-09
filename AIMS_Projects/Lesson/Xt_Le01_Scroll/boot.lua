--[[

  prototype boot.lua
  これはAIMSで新規にゲームを作成する際の
  プロトタイプとなるファイルです。
  適当に書き換えてご利用ください。

]]

-------------------------------------------
-- common呼び出し
-------------------------------------------

-- AIMSのファイルは全てprequire関数で読み込んでください。
-- ビルトインのrequireも使えますが、
-- requireではパッケージファイルの中をスキャンしてくれません。
prequire("common.lua");

-------------------------------------------
-- 定数初期化
-------------------------------------------

G = {}; -- グラフィックハンドルはこの下にぶら下げる
S = {}; -- サウンドハンドルはこの下に略
A = {}; -- 全体から扱いたいアクターのハンドルはこの下に

-- こうやってテーブルの下に分けておくと色々楽です

-------------------------------------------
-- 共有関数呼び出し
-------------------------------------------
--ゲーム中で共有する関数をprequireします。
prequire("s/blank.lua");

-------------------------------------------
-- ゲームシーン呼び出し
-------------------------------------------
--ゲームのシーンスクリプトをprequireします。

-------------------------------------------
-- OnLoad　起動直後に呼ばれる
-------------------------------------------
function OnLoad()

end

-------------------------------------------
-- OnStart
-------------------------------------------

-- 起動直後はbootシーンが呼ばれます。
function boot_OnStart()
	cls(); 
	clearLayerSettings();

	-- 1.まず画像を読み込む
	G.numbersBase = loadGraphic("gfx/NumbersBase.png");
	G.numbers = {}
	for i=0,14 do
		G.numbers[i] = cutGraphic(G.numbersBase,i*50,0,50,50);
	end
	G.frame = loadGraphic("gfx/Frame.png");

	-- 2.アクターを表示する。
	-- createActor(グラフィックハンドル, X座標, Y座標, レイヤー番号);
	-- レイヤー番号は0から11までの12枚で、数字が大きいほど上になります。
	A.numbers = {}
	for i=0,14 do
		row = math.floor(i / 3)
		col = i % 3
		A.numbers[i] = createActor(G.numbers[i], col*50+100, row*50+100, 10);
	end
	--枠。見た目1ドットずれているので x-1 して調整。
	A.frame = createActor(G.frame, 1*50+100-1, 2*50+100, 11);
	
	-- アクターに、ムーバーを追加する。60フレーム間を置いてスタート。
	for i=0,14 do
		addMover(A.numbers[i], 59, 1, MOVER_SETANGLE, 90, 0, 0);
		addMover(A.numbers[i], 59, 1, MOVER_SETSPEED,  5, 0, 0);
	end
	
	-- アクターに、ムーバーを追加する。10フレーム後、速度を 0 に。
	for i=0,14 do
		addMover(A.numbers[i], 59+10, 1, MOVER_SETSPEED,   0, 0, 0);
	end

end

-------------------------------------------
-- OnStep
-------------------------------------------
opening = 1
frame = 0
scroll=0
function boot_OnStep()


	--概要
	--【★１】最初の１回は10フレーム待つ。
	--【★２】２回目以降は、130フレーム間隔でスクロールの作り直しを行う。
	--　　　・　　 0frame ：【★３】最下段のアクターを削除。
	--　　　　　　　　　　：【★４】アクターハンドルを１段下の区画にずらす。
	--　　　　　　　　　　：【★５】最上段のアクターを新規作成。
	--　　　　　　　　　　：【★６】ムーバーを設定。
	--　　　・ 1～ 60frame：【★７】ムーバーの設定通りに、休止中。
	--　　　・61～ 70frame：【★８】ムーバーの設定通りに、アクターが１段下に向かってスクロール中。
	--　　　・71～130frame：【★２】ムーバーの設定通りに、休止中。


	remake = 0
	if(opening == 1)then
		if(frame==10)then--【★１】
			opening = 0
			remake = 1
		end
	elseif(0==(frame-10)%130)then--【★２】
		remake=1
	end

	if(remake==1)then
		--【★３】区画12,13,14のアクターを削除します。
		for i=12,14 do
			vanish(A.numbers[i]);
		end
		
		--【★４】区画のアクターハンドルを、ずらします。
		--		区画11のアクターハンドルを、区画14に入れます。
		--		区画10のアクターハンドルを、区画13に入れます。
		--		　…
		--		区画0のアクターハンドルを、区画3に入れます。
		for i=11,0,-1 do
			A.numbers[i+3] = A.numbers[i]
		end
		
		--【★５】区画0,1,2のアクターを新規作成します。
		--		（スクロールの回数　剰余　5行）×３　＝　０列目に作るアクター
		actorNumber = 12 - scroll%5*3
		for i=0,2 do
			row = 0
			col = i % 3
			A.numbers[i] = createActor(G.numbers[actorNumber], col*50+100, row*50+100, 10);
			actorNumber = actorNumber + 1
		end
		
		--【★６】アクターに、ムーバーを追加する。
		--		・60フレーム後にスタート。下を向き（90°）、速度を5にする。
		--		・70フレーム後に停止。速度を0にする。
		for i=0,14 do
			addMover(A.numbers[i], 60-1, 1, MOVER_SETANGLE, 90, 0, 0);--【★７】【★８】
			addMover(A.numbers[i], 60-1, 1, MOVER_SETSPEED,  5, 0, 0);
			addMover(A.numbers[i], (60-1)+10, 1, MOVER_SETSPEED,   0, 0, 0);--【★９】
		end
		
		scroll = scroll + 1
	end

	frame = frame + 1
end
-------------------------------------------
-- OnClose
-------------------------------------------
function boot_OnClose()
	-- 3.表示した画像を消去する
	vanish(A.numbers);
	
	-- 4.画像を開放する
	deleteGraphic(G.numbersBase);
	deleteGraphic(G.numbers);

	cls();
end

-------------------------------------------
-- OnVanish アプリ終了直前に呼ばれる
-------------------------------------------
function OnVanish()
	deleteAllGraphic(G);	-- グラフィック削除
	deleteAllSound(S);	-- サウンド削除
end
