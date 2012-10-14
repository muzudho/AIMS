--Sorry, Encoding of this file is Shift-JIS.

--【改変】このファイルは新規に追加。

--『鬼畜大王のAIMS/Luaライブラリー』
--Copyright (c) 2012, 鬼畜大王
--All rights reserved.
--ファイル作成    ：2012-10-14 鬼畜大王
--ファイル編集最終：2012-10-15 鬼畜大王

--[[
	使い方。

	（１）boot.luaの「共有関数呼び出し」部で、Luaファイルを読み込んでおきます。
		prequire("s/csv.lua");
		prequire("s/auto_image.lua");
		--その他、画像素材ファイルは用意されているものとします。

	（２）画像CSVを作成します。

		data/auto_image.csv

		（例）
		NO,ID,Expl,LOAD_TO_SOURCE,R_TRANSPARENT,G_TRANSPARENT,B_TRANSPARENT,HANDLE_CHIP_SOURCE,HANDLE_CHIP_DESTINATION,STARTINDEX_CHIP_DESTINATION,LEFT_CELL,TOP_CELL,WIDTH_CELL,HEIGHT_CELL,COLUMNS,ROWS,DELAY_ANIME,LOOPPOINT_ANIME,X_SETCENTER,Y_SETCENTER,R_FILL,G_FILL,B_FILL,A_FILL,LEFT_HIT,TOP_HIT,WIDTH_HIT,HEIGHT_HIT,END
		int,string,string,string,int,int,int,string,string,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,int,END
		-1,auto_ImageAt(...)の引数に渡されます。識別できれば何でも構わない。空白または「-1」を入れると無視されます。「Img:」「;」で挟んでおくと全文文字列置換しやすい。同じIDが連続している場合、続けて実行される。,コメント,（生成時）画像ファイルパス。HANDLE_CHIP_SOURCEで指定した変数に画像ハンドルが入れられる。LOAD_TO_SOURCEの指定がないときは、HANDLE_CHIP_SOURCEは既にセットされているものとして利用される。,（生成時）ロード時に透明にする色をＲＧＢ0～255で指定できる。「（空欄）」または「-1」で無視。,（生成時）,（生成時）,（生成時・編集時）画像ハンドルの名前。（この画像から切り抜く）。「G.」で始まること。例：「G.bullets.base」と記述。,（生成時）切り抜かれた画像のハンドルが入る変数名。 「G.」で始まること。例：「G.efx.blast」と記述。,（生成時）HANDLE_CHIP_DESTINATIONで指定した変数がテーブルだった時は、その開始インデックス。,切り抜き部分の左辺x。,切り抜き部分の上辺y。,切り抜き部分の横幅。,切り抜き部分の縦幅。,切り抜くコマが右に連続する列数。「（空欄）」または「-1」なら1。,切り抜くコマが下に連続する行数。「（空欄）」または「-1」なら1。,アニメーションさせる場合、１コマのwait間隔。ミリ秒。「（空欄）」または「-1」ならアニメーションしない。,終端の次は何コマ目に戻るか。先頭を1。「（空欄）」または「-1」ならループしない。,回転、拡縮の中心点を設定。左上を原点とする座標。「（空欄）」または「-1」で無視。全ての切り抜き画像に適応する。,,全領域をＲＧＢＡ0～255で塗りつぶします。RGBAの４つとも指定すると有効です。１つでも「（空欄）」または「-1」だと無視されます。画像ロードのときに有効です。,,,,当たり判定を設定します。４つ設定していると有効です。「（空欄）」または「-1」を指定すると無視。,,,,END

		～データ部分は大きいので紹介を割愛します。

	（３）画像を切り抜きたいタイミングで、次の関数を呼び出します。

		auto_ImageAt( "Img:player_init;" );	--引数はテーブルの「ID」列値。

	（４）必要に応じて auto_ImageAt関数内の
		local table = csv_FromFile( ～ )
		の部分を予め済ませて CSVテーブルをグローバル変数で持っておくと 処理の無駄が省けます。

	これで、外部ファイルで画像読込み等の操作を指定できます。
	以上。
]]

--外部ファイルに設定されている通りに、画像を用意します。
--id:この関数を置いている関数の名前を入れると便利です。空白または「-1」は入れないでください。
function auto_ImageAt( id )

	--データベース・テーブル。予め読み込んでグローバル変数に入れておく方法もある。
	local table = csv_FromFile("data/auto_image.csv")

	--レコード
	local hitsRecord
	local continueHits = 0 --連続してヒットしたレコード数
	local isFinish = false --ループを全部抜けるためのフラグ
	local numberRow = 1
	for numberRowB,record in pairs(table) do
		if 4<=numberRow then					--最初の３行はフィールド定義なので読み飛ばします。
			if record["ID"]==id then
				hitsRecord = record
				continueHits = continueHits + 1
				----------------------------------------------------------------
				--このレコードの処理開始


				local fieldLoadtosource
				fieldLoadtosource = hitsRecord["LOAD_TO_SOURCE"];
				if("-1"==fieldLoadtosource)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldLoadtosource = ""
				end

				local fieldRtransparent
				fieldRtransparent = hitsRecord["R_TRANSPARENT"];
				if("-1"==fieldRtransparent)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldRtransparent = ""
				end

				local fieldGtransparent
				fieldGtransparent = hitsRecord["G_TRANSPARENT"];
				if("-1"==fieldGtransparent)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldGtransparent = ""
				end

				local fieldBtransparent
				fieldBtransparent = hitsRecord["B_TRANSPARENT"];
				if("-1"==fieldBtransparent)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldBtransparent = ""
				end

				local fieldXsetcenter
				fieldXsetcenter = hitsRecord["X_SETCENTER"];
				if(""==fieldXsetcenter)then
					--空白は -1 扱い（入力を無かったことに）。
					fieldXsetcenter = -1
				else
					fieldXsetcenter = tonumber( fieldXsetcenter )
				end

				local fieldYsetcenter
				fieldYsetcenter = hitsRecord["Y_SETCENTER"];
				if(""==fieldYsetcenter)then
					--空白は -1 扱い（入力を無かったことに）。
					fieldYsetcenter = -1
				else
					fieldYsetcenter = tonumber( fieldYsetcenter )
				end

				local fieldRfill
				fieldRfill = hitsRecord["R_FILL"];
				if(""==fieldRfill)then
					--空白は -1 扱い（入力を無かったことに）。
					fieldRfill = -1
				else
					fieldRfill = tonumber( fieldRfill )
				end

				local fieldGfill
				fieldGfill = hitsRecord["G_FILL"];
				if(""==fieldGfill)then
					--空白は -1 扱い（入力を無かったことに）。
					fieldGfill = -1
				else
					fieldGfill = tonumber( fieldGfill )
				end

				local fieldBfill
				fieldBfill = hitsRecord["B_FILL"];
				if(""==fieldBfill)then
					--空白は -1 扱い（入力を無かったことに）。
					fieldBfill = -1
				else
					fieldBfill = tonumber( fieldBfill )
				end

				local fieldAfill
				fieldAfill = hitsRecord["A_FILL"];
				if(""==fieldAfill)then
					--空白は -1 扱い（入力を無かったことに）。
					fieldAfill = -1
				else
					fieldAfill = tonumber( fieldAfill )
				end

				local fieldHandlechipsource
				fieldHandlechipsource = hitsRecord["HANDLE_CHIP_SOURCE"];
				if("-1"==fieldHandlechipsource)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldHandlechipsource = ""
				end

				local fieldLeftcell
				fieldLeftcell = hitsRecord["LEFT_CELL"];
				if("-1"==fieldLeftcell)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldLeftcell = ""
				end

				local fieldTopcell
				fieldTopcell = hitsRecord["TOP_CELL"];
				if("-1"==fieldTopcell)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldTopcell = ""
				end

				local fieldWidthcell
				fieldWidthcell = hitsRecord["WIDTH_CELL"];
				if("-1"==fieldWidthcell)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldWidthcell = ""
				end

				local fieldHeightcell
				fieldHeightcell = hitsRecord["HEIGHT_CELL"];
				if("-1"==fieldHeightcell)then
					--空白および「-1」は空白扱い（入力を無かったことに）。
					fieldHeightcell = ""
				end


				local handleImage
				handleImage = nil

				if(""~=fieldLoadtosource)then
					--ロードする画像のファイルパスが指定されていれば、ロードします。
					if(
						""~=fieldRtransparent and
						""~=fieldGtransparent and
						""~=fieldBtransparent
					)then
						handleImage = loadGraphic( fieldLoadtosource, tonumber(fieldRtransparent), tonumber(fieldGtransparent), tonumber(fieldBtransparent) )
					else
						handleImage = loadGraphic( fieldLoadtosource )
					end

					if(-1~=fieldXsetcenter and -1~=fieldYsetcenter)then
						setGraphicCenter( handleImage, fieldXsetcenter, fieldYsetcenter );
					end
				elseif(
					""==fieldLeftcell and
					""==fieldTopcell and
					""~=fieldWidthcell and
					""~=fieldHeightcell
				)then
					--ファイルパスの指定がなく、
					--座標指定もなく、
					--サイズ指定があれば、ブランク画像を作成します。
					handleImage = createBlankGraphic( tonumber(fieldWidthcell), tonumber(fieldHeightcell) );
				else
					
				end

				if(
					fieldRfill~=-1 and
					fieldGfill~=-1 and
					fieldBfill~=-1 and
					fieldAfill~=-1
				)then
					--塗りつぶしの指定があれば、塗りつぶします。
					fillGraphic( handleImage, fieldRfill, fieldGfill, fieldBfill, fieldAfill );
				end


				if(nil~=handleImage and ""~=fieldHandlechipsource)then
					--画像をロードしていて、画像チップの変数名も指定されている場合、代入します。
					--例えば「G.ballets.base = handleImage」という操作をします。
					auto_GlobalTableSet( fieldHandlechipsource, handleImage )
				end





				--ここで大きく処理内容が変わります。
				if(nil==handleImage)then
					--画像を読み取っていない場合。

					local fieldHandlechipdestination
					fieldHandlechipdestination = hitsRecord["HANDLE_CHIP_DESTINATION"];
					if("-1"==fieldHandlechipdestination)then
						--空白および「-1」は空白扱い（入力を無かったことに）。
						fieldHandlechipdestination = ""
					end

					local fieldStartindexchipdestination
					fieldStartindexchipdestination = hitsRecord["STARTINDEX_CHIP_DESTINATION"];
					if(""==fieldStartindexchipdestination)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldStartindexchipdestination = -1
					else
						fieldStartindexchipdestination = tonumber( fieldStartindexchipdestination )
					end

					--読込み済み local fieldHandlechipsource

					--読込み済み local fieldWidthcell

					--読込み済み local fieldHeightcell

					local fieldColumns
					fieldColumns = hitsRecord["COLUMNS"];
					if("-1"==fieldColumns or ""==fieldColumns)then
						--空白および「-1」は 1 扱い。
						fieldColumns = 1
					else
						fieldColumns = tonumber(fieldColumns)
					end

					local fieldRows
					fieldRows = hitsRecord["ROWS"];
					if("-1"==fieldRows or ""==fieldRows)then
						--空白および「-1」は 1 扱い。
						fieldRows = 1
					else
						fieldRows = tonumber(fieldRows)
					end

					local fieldDelayanime
					fieldDelayanime = hitsRecord["DELAY_ANIME"];
					if(""==fieldDelayanime)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldDelayanime = -1
					else
						fieldDelayanime = tonumber( fieldDelayanime )
					end

					local fieldLooppointanime
					fieldLooppointanime = hitsRecord["LOOPPOINT_ANIME"];
					if(""==fieldLooppointanime)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldLooppointanime = -1
					else
						fieldLooppointanime = tonumber( fieldLooppointanime )
					end

					local fieldXsetcenter
					fieldXsetcenter = hitsRecord["X_SETCENTER"];
					if(""==fieldXsetcenter)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldXsetcenter = -1
					else
						fieldXsetcenter = tonumber( fieldXsetcenter )
					end

					local fieldYsetcenter
					fieldYsetcenter = hitsRecord["Y_SETCENTER"];
					if(""==fieldYsetcenter)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldYsetcenter = -1
					else
						fieldYsetcenter = tonumber( fieldYsetcenter )
					end

					local fieldLefthit
					fieldLefthit = hitsRecord["LEFT_HIT"];
					if(""==fieldLefthit)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldLefthit = -1
					else
						fieldLefthit = tonumber( fieldLefthit )
					end

					local fieldTophit
					fieldTophit = hitsRecord["TOP_HIT"];
					if(""==fieldTophit)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldTophit = -1
					else
						fieldTophit = tonumber( fieldTophit )
					end

					local fieldWidthhit
					fieldWidthhit = hitsRecord["WIDTH_HIT"];
					if(""==fieldWidthhit)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldWidthhit = -1
					else
						fieldWidthhit = tonumber( fieldWidthhit )
					end

					local fieldHeighthit
					fieldHeighthit = hitsRecord["HEIGHT_HIT"];
					if(""==fieldHeighthit)then
						--空白は -1 扱い（入力を無かったことに）。
						fieldHeighthit = -1
					else
						fieldHeighthit = tonumber( fieldHeighthit )
					end


					--切り取られる方の画像のハンドルに立場が変わります。
					if(""~=fieldHandlechipsource)then
						local handleExists
						handleExists = auto_GlobalTable( fieldHandlechipsource )
						
						if(nil~=handleExists)then
							--引数を上書き
							handleImage = handleExists
						else
							--無い名前の変数を指定した場合。
							--例えば「G.bullets」と書いているが、ヌルの場合。

							--テーブルを作成します。
							auto_GlobalTableSet( fieldHandlechipsource, {} )
						end
					end


					local handleImagecrop --切り取り後の画像のハンドル
					handleImagecrop = nil

					local indexStart
					indexStart = nil
					
					if(-1~=fieldStartindexchipdestination)then
						--引数を上書き
						indexStart = fieldStartindexchipdestination
					end

					if(
						2 <= fieldColumns or
						2 <= fieldRows
					)then
						--縦か横、または両方に並んでいる場合

						local tableTarget
						tableTarget = auto_GlobalTable( fieldHandlechipdestination )

						if(
							""==fieldLeftcell or
							""==fieldTopcell or
							""==fieldWidthcell or
							""==fieldHeightcell
						)then
							--記入に不備があれば、無視します。
						else
							local numberWidth, numberHeight, numberColumns
							numberWidth  = tonumber(fieldWidthcell)
							numberHeight = tonumber(fieldHeightcell)
							numberColumns = fieldColumns
							numberRows = fieldRows

							local last
							last = numberColumns * numberRows

							local index
							index = indexStart
							for current=1,last,1 do
								handleImagecrop = cutGraphic(
									handleImage,
									numberWidth *math.mod  ( current-1               ,numberColumns)+fieldLeftcell,
									numberHeight*math.floor((current-1)/numberColumns              )+fieldTopcell,
									numberWidth,
									numberHeight
									);
								
								if(-1~=fieldXsetcenter and -1~=fieldYsetcenter)then
									setGraphicCenter( handleImagecrop, fieldXsetcenter, fieldYsetcenter );
								end

								if(-1~=fieldLefthit and -1~=fieldTophit and -1~=fieldWidthhit and -1~=fieldHeighthit)then
									setGraphicHit( handleImagecrop, fieldLefthit, fieldTophit, fieldWidthhit, fieldHeighthit )
								end
								
								tableTarget[index] = handleImagecrop
								index = index + 1
							end
							
							--アニメ設定
							if( -1~=fieldDelayanime )then
								if( -1~=fieldLooppointanime )then
									setGraphicAnimeLoop( tableTarget, fieldDelayanime, fieldLooppointanime )
								else
									setGraphicAnimeSequence( tableTarget, fieldDelayanime );
								end
							end
						end
					else
						if(
							""==fieldLeftcell or
							""==fieldTopcell or
							""==fieldWidthcell or
							""==fieldHeightcell
						)then
							--記入に不備があれば、無視します。
						else
							handleImagecrop = cutGraphic( handleImage, tonumber(fieldLeftcell), tonumber(fieldTopcell), tonumber(fieldWidthcell), tonumber(fieldHeightcell) )
							
							if(-1~=fieldXsetcenter and -1~=fieldYsetcenter)then
								setGraphicCenter( handleImagecrop, fieldXsetcenter, fieldYsetcenter );
							end
							
							if(-1~=fieldLefthit and -1~=fieldTophit and -1~=fieldWidthhit and -1~=fieldHeighthit)then
								setGraphicHit( handleImagecrop, fieldLefthit, fieldTophit, fieldWidthhit, fieldHeighthit )
							end
						end
						
						if(""~=fieldHandlechipdestination)then
							--指定のテーブルに、新しいテーブルを追加します。
							--例えば第一引数の内容が「ballets.base」なら、「G.ballets.base = handleImage」という操作をします。
							auto_GlobalTableSet( fieldHandlechipdestination, handleImagecrop )
						end
					end
				end
				----------------------------------------------------------------
				--次のレコードへ
			elseif(0<continueHits)then
				--ヒットが途切れた時
				--処理終了
				isFinish = true
				break
			end
		end
		
		numberRow = numberRow + 1
		if(isFinish)then
			--ループ脱出
			break
		end
	end
end

--fieldNamenewtable:「G.efx.blast.base」といった変数名。
function auto_GlobalTable( fieldNamenewtable )
	local tableTarget
	
	if(""~=fieldNamenewtable)then
		if(nil==string.match(fieldNamenewtable,"^G%."))then
			error("関数auto_GlobalTableの第一引数の内容は、先頭が「G.」でなければなりません。fieldNamenewtable=["..fieldNamenewtable.."]",2)
		end

		--頭の「G.」を取る。
		fieldNamenewtable = string.sub( fieldNamenewtable, 3 )

		local indexDot
		indexDot = string.find( fieldNamenewtable, ".", 1, true)

		if(nil==indexDot)then
			--引数が"ballets"といったような形。「.」で区切られていない。
			tableTarget = G[fieldNamenewtable]
		else
			--引数が"ballets.base"といったような形。「.」で区切られている。
			
			local arrayNode
			arrayNode = csv_Split( fieldNamenewtable, "[.]" ) --「.」でスプリットしたい場合は「[.]」と書く。
			
			tableTarget = G[arrayNode[1]]
			
			--引数を上書き（指定された一番下のテーブルに移動している）。#arrayNode は、最後の添え字番号と同等。
			for indexNode=2,#arrayNode,1 do
				tableTarget = tableTarget[arrayNode[indexNode]]
			end
		end
	end

	return tableTarget
end

function auto_GlobalTableSet( fieldNamenewtable, valueNew )
	if(""~=fieldNamenewtable)then
		if(nil==string.match(fieldNamenewtable,"^G%."))then
			error("関数auto_GlobalTableの第一引数の内容は、先頭が「G.」でなければなりません。fieldNamenewtable=["..fieldNamenewtable.."]",2)
		end

		--頭の「G.」を取る。
		fieldNamenewtable = string.sub( fieldNamenewtable, 3 )

		local indexDot
		indexDot = string.find( fieldNamenewtable, ".", 1, true)

		if(nil==indexDot)then
			--引数が"ballets"といったような形。「.」で区切られていない。
			G[fieldNamenewtable] = valueNew
		else
			--引数が"ballets.base"といったような形。「.」で区切られている。
			
			local arrayNode
			arrayNode = csv_Split( fieldNamenewtable, "[.]" ) --「.」でスプリットしたい場合は「[.]」と書く。
			
			local tableLastparent --下から二番目のテーブル
			tableLastparent = G[arrayNode[1]]
			
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

--【/改変】このファイルは新規に追加。
