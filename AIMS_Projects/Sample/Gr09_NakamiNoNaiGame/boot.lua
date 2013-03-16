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
prequire("s/scene/battle.lua");
prequire("s/scene/chrsel.lua");
prequire("s/scene/ending.lua");
prequire("s/scene/load.lua");
prequire("s/scene/lose.lua");
prequire("s/scene/map.lua");
prequire("s/scene/menu.lua");
prequire("s/scene/name.lua");
prequire("s/scene/prolog.lua");
prequire("s/scene/staff.lua");
prequire("s/scene/stgsel.lua");
prequire("s/scene/talk.lua");
prequire("s/scene/title.lua");
prequire("s/scene/win.lua");

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
end

-------------------------------------------
-- OnStep
-------------------------------------------
function boot_OnStep()
	changeScene("title")
end
-------------------------------------------
-- OnClose
-------------------------------------------
function boot_OnClose()
	cls();
end

-------------------------------------------
-- OnVanish アプリ終了直前に呼ばれる
-------------------------------------------
function OnVanish()
	deleteAllGraphic(G);	-- グラフィック削除
	deleteAllSound(S);	-- サウンド削除
end
