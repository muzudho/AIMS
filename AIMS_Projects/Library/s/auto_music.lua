--Sorry, Encoding of this file is Shift-JIS.

--【改変】このファイルは新規に追加。

--『鬼畜大王のAIMS/Luaライブラリー』
--Copyright (c) 2012, 鬼畜大王
--All rights reserved.
--ファイル作成    ：2012-10-14 鬼畜大王
--ファイル編集最終：2012-10-14 鬼畜大王

--[[
	使い方。

	（１）boot.luaの「共有関数呼び出し」部で、Luaファイルを読み込んでおきます。
		prequire("s/csv.lua");
		prequire("s/auto_music.lua");
		--その他、音楽素材ファイルは用意されているものとします。

	（２）音楽CSVを作成します。

		data/auto_music.csv

		（例）
		NO,ID,INTRO,LOOP,NO_REPEAT,FADEOUT,WAIT_WITH_FADEOUT,END,,,,,,,,,,,,,,,,,,,,,,,
		int,string,string,string,string,int,int,END,,,,,,,,,,,,,,,,,,,,,,,
		-1,auto_MusicAt(...)が置かれている関数名を入れると便利です。識別できれば何でも構わない。空白または「-1」を入れると無視されます。,イントロ部分（または丸ごと）のファイル名。「（空白）」または「-1」で無視。,ループ部分のファイル名（あれば）,「Yes」…ループしない。「（空白）」…ループする。,フェードアウトにかけるミリ秒。「（空白）」または「-1」で無視。,フェードアウト時間を指定した場合、同時にゲームをwaitするミリ秒を指定できます。「（空白）」または「-1」で無視。,END,,,,,,,,,,,,,,,,,,,,,,,
		-1,,"Sorry, Encoding of this csv file is Shift-JIS.（このCSVファイルはShift-JISエンコーディングです。）",,,,,END,,,,,,,,,,,,,,,,,,,,,,,END
		0,,このファイルはサンプルです。,,,,,END,,,,,,,,,,,,,,,,,,,,,,,
		1,game_OnStart,mus/stage_lp.ogg,,,,,END,,,,,,,,,,,,,,,,,,,,,,,
		2,title_OnStart,mus/title_in.ogg,mus/title_lp.ogg,,,,END,,,,,,,,,,,,,,,,,,,,,,,
		3,thread_gameover,,,,180,180,END,,,,,,,,,,,,,,,,,,,,,,,
		EOF,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

	（３）音楽を切り替えたいタイミングで、次の関数を呼び出します。

		auto_MusicAt("game_OnStart");	--引数はテーブルの「ID」列値。これを呼び出している関数の名前を入れると便利。

	これで、外部ファイルで音楽の操作を指定できます。
	以上。
]]


--外部ファイルと照らし合わせて、シーン移動します。
--id:この関数を置いている関数の名前を入れると便利です。空白または「-1」は入れないでください。
function auto_MusicAt(id)


	--データベース・テーブル
	local table = csv_FromFile("data/auto_music.csv")

	--レコード
	local hitsRecord
	local numberRow = 1
	for numberRowB,record in pairs(table) do
		if 4<=numberRow then					--最初の３行はフィールド定義なので読み飛ばします。
			if record["ID"]==id then
				hitsRecord = record
				break
			end
		end
		
		numberRow = numberRow + 1
	end

	local fieldIntro
	fieldIntro = hitsRecord["INTRO"];
	if("-1"==fieldIntro)then
		--空白および「-1」は空白扱い（入力を無かったことに）。
		fieldIntro = ""
	end

	local fieldLoop
	fieldLoop = hitsRecord["LOOP"];
	if("-1"==fieldLoop)then
		--空白および「-1」は空白扱い（入力を無かったことに）。
		fieldLoop = ""
	end

	local fieldNorepeat
	fieldNorepeat = hitsRecord["NO_REPEAT"];
	if("-1"==fieldNorepeat)then
		--空白および「-1」は空白扱い（入力を無かったことに）。
		fieldNorepeat = ""
	end

	local fieldFadeout
	fieldFadeout = hitsRecord["FADEOUT"];
	if("-1"==fieldFadeout)then
		--空白および「-1」は空白扱い（入力を無かったことに）。
		fieldFadeout = ""
	end

	local fieldWaitwithfadeout
	fieldWaitwithfadeout = hitsRecord["WAIT_WITH_FADEOUT"];
	if("-1"==fieldWaitwithfadeout)then
		--空白および「-1」は空白扱い（入力を無かったことに）。
		fieldWaitwithfadeout = ""
	end


	if(""==fieldIntro)then
		--音楽を切り替えません。
	elseif("Yes"==fieldNorepeat)then
		--再生（ループなし）
		playMusic( fieldIntro )
	else
		if(""~=fieldLoop)then
			--再生（ループ部をループ）
			playMusicLoop( fieldIntro, fieldLoop )
		else
			--再生（丸ごとループ）
			playMusicLoop( fieldIntro )
		end
	end

	if(""~=fieldFadeout)then
		fadeMusic( tonumber(fieldFadeout) )

		if(""~=fieldWaitwithfadeout)then
			wait( tonumber(fieldWaitwithfadeout) )
		end
	end

end

--【/改変】このファイルは新規に追加。
