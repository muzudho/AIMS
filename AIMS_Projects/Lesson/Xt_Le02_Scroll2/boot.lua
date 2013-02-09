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
cellHeight = 80 --１区画の縦幅

-- 起動直後はbootシーンが呼ばれます。
function boot_OnStart()
	cls(); 
	clearLayerSettings();

	-- 1.まず画像を読み込む
	--枠
	G.frame = loadGraphic("gfx/Frame.png");
	--顔
	G.face = loadGraphic("gfx/Face.png");
	--フォント
	G.font = createAsciiFont("gfx/font16.png", 16, 16);
	--アイコン
	G.iconsBase = loadGraphic("gfx/IconsBase.png");
	G.icons = {}
	for i=0,7 do
		G.icons[i] = cutGraphic(G.iconsBase,i*20,0,20,20);
	end
	--数字
	G.numbersBase = loadGraphic("gfx/NumbersBase.png");
	G.numbers = {}
	for i=0,14 do
		G.numbers[i] = cutGraphic(G.numbersBase,i*20,0,20,20);
	end

	-- 2.アクターを表示する。
	A.items = {}
	--枠。見た目1ドットずれているので x-1 して調整。
	-- createActor(グラフィックハンドル, X座標, Y座標, レイヤー番号);
	-- レイヤー番号は0から11までの12枚で、数字が大きいほど上になります。
	A.frame = createActor(G.frame, 300-1, 250, 11);
end

-------------------------------------------
-- OnStep
-------------------------------------------
opening = 1
frame = 0
scroll=0
ox=50 --原点x
oy=50
function boot_OnStep()


	--概要
	--【★１】最初の１回は10フレーム待つ。
	--【★２】２回目以降は、130フレーム間隔でスクロールの作り直しを行う。
	--　　　・　　 0frame ：【★３】最下段のアクターを削除。
	--　　　　　　　　　　：【★４】アクターハンドルを１段下の区画にずらす。
	--　　　　　　　　　　：【★５】最上段のアクターを格納する変数をクリアー。
	--　　　　　　　　　　：【★６】最上段のアクターを新規作成。
	--　　　　　　　　　　：【★７】ムーバーを設定。
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
		--【★３】区画60～74のアクターを削除します。
		for i=60,74 do
			hActor = A.items[i]
			if(isAlive(hActor))then
				vanish(hActor);
			end
			A.items[i] = 0
		end

		--【★４】区画のアクターハンドルを、ずらします。
		for i=59,0,-1 do
			A.items[i+15] = A.items[i]
		end

		--【★５】ずらした後で、区画0～14を空にします。
		--アクターを新規作成する前に実行しないと、画面上に既に出ているアクターが消えることがあります。
		for i=14,0,-1 do
			A.items[i] = 0
		end

		--【★６】区画0～14のアクターを新規作成します。
		if(2==scroll%5)then
			--顔
			i=0
			A.items[i] = createActor( G.face, 90, 90, 10 );
			--名前
			i = i + 1
			A.items[i] = createTextActor( G.font, "ｴﾐﾘｰ", 180+ox, 18+oy, 10 );
			--職業アイコン
			i = i + 1
			A.items[i] = createActor( G.icons[2], 120+ox, 54+oy, 10 );
			--職業名
			i = i + 1
			A.items[i] = createTextActor( G.font, "ﾏﾎｳﾂｶｲ", 180+ox, 46+oy, 10 );
			--HP
			i = i + 1
			A.items[i] = createActor( G.icons[0], 350+ox, 26+oy, 10 );
			--HP百の位
			i = i + 1
			A.items[i] = createActor( G.numbers[1], 390+ox, 26+oy, 10 );
			--HP十の位
			i = i + 1
			A.items[i] = createActor( G.numbers[0], 430+ox, 26+oy, 10 );
			--HP一の位
			i = i + 1
			A.items[i] = createActor( G.numbers[0], 470+ox, 26+oy, 10 );
			--MP
			i = i + 1
			A.items[i] = createActor( G.icons[1], 350+ox, 54+oy, 10 );
			--MP百の位
			i = i + 1
			A.items[i] = createActor( G.numbers[10], 390+ox, 54+oy, 10 );
			--MP十の位
			i = i + 1
			A.items[i] = createActor( G.numbers[1], 430+ox, 54+oy, 10 );
			--MP一の位
			i = i + 1
			A.items[i] = createActor( G.numbers[9], 470+ox, 54+oy, 10 );
			--残りは削除
			for i=12,14 do
				hActor = A.items[i]
				if(isAlive(hActor))then
					vanish(hActor);
				end
			end
		elseif(1==scroll%5)then
			--武器アイコン
			i = 0
			A.items[i] = createActor( G.icons[3], 120+ox, 26+oy, 10 );
			--武器名
			i = i + 1
			A.items[i] = createTextActor( G.font, "ﾔｽﾓﾉﾉﾛｯﾄﾞ", 180+ox, 18+oy, 10 );
			--防具アイコン
			i = i + 1
			A.items[i] = createActor( G.icons[4], 120+ox, 54+oy, 10 );
			--防具名
			i = i + 1
			A.items[i] = createTextActor( G.font, "ﾔｽﾓﾉﾉﾛｰﾌﾞ", 180+ox, 46+oy, 10 );
			--残りは削除
			for i=4,14 do
				hActor = A.items[i]
				if(isAlive(hActor))then
					vanish(hActor);
				end
			end
		elseif(0==scroll%5)then
			--スキル1アイコン
			i = 0
			A.items[i] = createActor( G.icons[5], 120+ox, 20+oy, 10 );
			--スキル1名
			i = i + 1
			A.items[i] = createTextActor( G.font,"ﾌｧｲｱｰ", 180+ox, 12+oy, 10 );
			--MPアイコン
			i = i + 1
			A.items[i] = createActor( G.icons[1], 390+ox, 20+oy, 10 );
			--MP十の位
			i = i + 1
			A.items[i] = createActor( G.numbers[10], 430+ox, 20+oy, 10 );
			--MP一の位
			i = i + 1
			A.items[i] = createActor( G.numbers[3], 470+ox, 20+oy, 10 );

			--スキル2アイコン
			i = i + 1
			A.items[i] = createActor( G.icons[6], 120+ox, 40+oy, 10 );
			--スキル1名
			i = i + 1
			A.items[i] = createTextActor( G.font, "ﾗｲﾄﾆﾝｸﾞ", 180+ox, 32+oy, 10 );
			--MPアイコン
			i = i + 1
			A.items[i] = createActor( G.icons[1], 390+ox, 40+oy, 10 );
			--MP十の位
			i = i + 1
			A.items[i] = createActor( G.numbers[10], 430+ox, 40+oy, 10 );
			--MP一の位
			i = i + 1
			A.items[i] = createActor( G.numbers[7], 470+ox, 40+oy, 10 );

			--スキル3アイコン
			i = i + 1
			A.items[i] = createActor( G.icons[6], 120+ox, 60+oy, 10 );
			--スキル1名
			i = i + 1
			A.items[i] = createTextActor( G.font, "ﾗｲﾄﾆﾝｸﾞ", 180+ox, 52+oy, 10 );
			--MPアイコン
			i = i + 1
			A.items[i] = createActor( G.icons[1], 390+ox, 60+oy, 10 );
			--MP十の位
			i = i + 1
			A.items[i] = createActor( G.numbers[1], 430+ox, 60+oy, 10 );
			--MP一の位
			i = i + 1
			A.items[i] = createActor( G.numbers[5], 470+ox, 60+oy, 10 );

		else
			--全部削除
			for i=0,14 do
				hActor = A.items[i]
				if(isAlive(hActor))then
					vanish(hActor);
				end
			end
		end
		
		--【★７】アクターに、ムーバーを追加する。
		--		・60フレーム後にスタート。下を向き（90°）、速度を8にする。
		--		・70フレーム後に停止。速度を0にする。
		for i=0,74 do
			hActor = A.items[i]
			if(isAlive(hActor))then
				addMover(hActor, 60-1, 1, MOVER_SETANGLE, 90, 0, 0);--【★７】【★８】
				addMover(hActor, 60-1, 1, MOVER_SETSPEED,  8, 0, 0);
				addMover(hActor, (60-1)+10, 1, MOVER_SETSPEED,   0, 0, 0);--【★９】
			end
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
	vanish(A.items);
	
	-- 4.画像を開放する
	deleteGraphic(G.numbersBase);
	deleteGraphic(G.numbers);
	deleteGraphic(G.face);
	deleteGraphic(G.font);
	deleteGraphic(G.iconsBase);
	deleteGraphic(G.icons);

	cls();
end

-------------------------------------------
-- OnVanish アプリ終了直前に呼ばれる
-------------------------------------------
function OnVanish()
	deleteAllGraphic(G);	-- グラフィック削除
	deleteAllSound(S);	-- サウンド削除
end
