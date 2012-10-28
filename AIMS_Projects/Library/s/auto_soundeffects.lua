--Sorry, Encoding of this file is Shift-JIS.

-- 【改変】このファイルは新規に追加。

--『鬼畜大王のAIMS/Luaライブラリー』
--Copyright (c) 2012, 鬼畜大王
--All rights reserved.
--ファイル作成    ：2012-10-28 鬼畜大王
--ファイル編集最終：2012-10-28 鬼畜大王

--[[
	[使い方]
	
	（１）次の３つのファイルを、GitHub から手に入れます。
		・～/s/csv.lua
		・～/s/auto_soundeffects.lua （このファイル）
		・～/auto_soundeffects.csv （サンプルとして持っていく）

	（２）boot.luaファイルの中で、prequire文を追加・削除します。
		-------------------------------------------
		-- common呼び出し
		-------------------------------------------
		【～中略～】
		--【追加】ここから--
		prequire("s/csv.lua");
		prequire("s/auto_soundeffects.lua");
		--【/追加】ここまで--
		【～中略～】
		--prequire("s/se.lua"); --これを削除。
		【～後略～】

	（３）s/se.lua を削除します。

	（４）サウンドファイルを登録したCSVを作成します。
		  サンプルを持っていって改造するか、一から入力してください。

		～/auto_soundeffects.csv

		（例）
		NO,Expl,VARIABLE,FILE,END
		int,string,string,string,END
		-1,解説,.luaで使うときの効果音ハンドルを持つ変数,.exeからのファイルパス。,END
		-1,"Sorry, Encoding of this csv file is Shift-JIS.（このCSVファイルはShift-JISエンコーディングです。）",,,END
		0,プレイヤーショット音,S.pshot,se/pshot.wav,END
		【～中略～】
		EOF,,,,

	（５）『suica32』の場合ですと、s/game_common.lua の中の initializer() に
		下記を追加してください。

		-- 各種初期化ルーチンを一斉に呼び出す
		function initializer()
			for index,func in pairs(INITIALIZER_LIST) do
				func();
			end

			--【改変】追加と削除。ここから。
			--サウンドエフェクトをロードし、そのハンドルをグローバル変数「S」にセットします。
			auto_SoundeffectsLoad()
			--【/改変】追加と削除。ここまで。
		end	

	これで、サウンドファイルは読込完了され、グローバル変数「S」に
	サウンドファイルのハンドルがセットされています。
	以上。
]]


function auto_SoundeffectsLoad()

	local csvTable = csv_FromFile( "data/auto_soundeffects.csv" );

	--全てのデータ部レコードを調査・判断・実行します。
	local hitsRecord
	local rowNum=1
	for number_Row,record in pairs(csvTable) do
		if 4<=rowNum then

			local variable = record["VARIABLE"]
			local file     = record["FILE"]
			
			if ""~=variable and ""~=file then
				--記入があれば
				
				local handleSound
				handleSound = loadSound( file );
				auto_GlobalSTableSet( variable, handleSound )
			end
		end
		
		rowNum = rowNum + 1
	end
end

--グローバル変数「S」に値をセットします。
function auto_GlobalSTableSet( fieldNamenewtable, valueNew )
	if(""~=fieldNamenewtable)then
		if(nil==string.match(fieldNamenewtable,"^S%."))then
			error("関数auto_GlobalSTableSetの第一引数の内容は、先頭が「S.」でなければなりません。fieldNamenewtable=["..fieldNamenewtable.."]",2)
		end

		--頭の「S.」を取る。
		fieldNamenewtable = string.sub( fieldNamenewtable, 3 )

		local indexDot
		indexDot = string.find( fieldNamenewtable, ".", 1, true)

		if(nil==indexDot)then
			--引数が"ballets"といったような形。「.」で区切られていない。
			S[fieldNamenewtable] = valueNew
		else
			--引数が"ballets.base"といったような形。「.」で区切られている。
			
			local arrayNode
			arrayNode = csv_Split( fieldNamenewtable, "[.]" ) --「.」でスプリットしたい場合は「[.]」と書く。
			
			local tableLastparent --下から二番目のテーブル
			tableLastparent = S[arrayNode[1]]
			
			local lastParent
			lastParent = #arrayNode - 1

			--配列の形「a[b]」にも対応する。
			local nameNodeA, nameNodeB, indexB

			--引数を上書き（指定された下から二番目のテーブルに移動している）。#arrayNode は、最後の添え字番号と同等。
			for indexNode=2,lastParent,1 do
				nameNodeA = arrayNode[indexNode]
				nameNodeB, indexB = string.match( nameNodeA, "(.+)%s*%[%s*(%d+)%s*%]" )
				if( nil~=nameNodeB and nil~=indexB )then
					tableLastparent[nameNodeB][tonumber(indexB)] = valueNew
				else
					tableLastparent = tableLastparent[nameNodeA]
				end
			end
			
			--「a[b]」といった配列の形をしていた場合、処理を分ける。
			nameNodeA = arrayNode[#arrayNode]
			nameNodeB, indexB = string.match( nameNodeA, "(.+)%s*%[%s*(%d+)%s*%]" )
			if( nil~=nameNodeB and nil~=indexB )then
				tableLastparent[nameNodeB][tonumber(indexB)] = valueNew
			else
				tableLastparent[nameNodeA] = valueNew
			end
			
		end
	else
		--名無しが指定されたので無視。
	end
end


-- 【/改変】このファイルは新規に追加。
