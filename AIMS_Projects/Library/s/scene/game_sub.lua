--Sorry, Encoding of this file is Shift-JIS.

--【改変】このファイルは新規に追加。A.I.M.Sサンプル『suica32』の
--「s/chr/enemy_gen.lua」を元に改変した。

--『鬼畜大王のLuaライブラリー』
--Copyright (c) 2012, 鬼畜大王
--All rights reserved.
--ファイル作成    ：2012-10-08 鬼畜大王
--ファイル編集最終：2012-10-08 鬼畜大王


--------------------------------------------------------------------------------
-- 定義定数一覧（サンプル）

-- ゲーム定数

	--[[
		メモ
			画面サイズ横縦（640x480 pixel）
			画面の横幅の中央 320px
			ゲーム表示領域の横幅（両端の黒い部分に挟まれたところ） 360px
			ゲーム表示領域の左辺と右辺X 140,500
			ゲーム画面上方のザコ敵出現ラインY（サンプル） 32
			ゲーム画面上方のボス敵出現ラインY（サンプル） 1
			ザコ敵が横から出てくるときの出現ラインY（サンプル） 0～450
	]]

--[[common.luaにカット＆ペーストしてください。
GAME_LEFT  = 140				-- ゲーム画面の左辺x

SCOREBASE_ZAKO = 150		-- 通常ザコの基礎点数
SCOREBASE_ZAKOHOMING = 100	-- 自機追尾ザコの基礎点数
SCOREBASE_LAZER = 700		-- レーザーザコの基礎点数
SCOREBASE_BOSS = 5000		-- ボスの基礎点数
]]
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- 敵生成スレッド 
--------------------------------------------------------------------------------

--[[
	使い方。
	
	（１）
		・s/chr/enemy.luaから
			prequire("s/chr/enemy_gen.lua"); -- 敵生成スレッド
		を削除します。
		
		・s/chr/enemy_gen.lua ファイル自体も削除します。
		
		・boot.luaに
			prequire("s/scene/game_sub.lua");
		を追加します。このファイルです。
		
		・このファイルを s/scene/game_sub.lua として配置します。

	（２）common.luaに、
		このファイルの上部でコメントアウトしているゲーム定数を切り取って、
		貼り付けてください。
	
	（３）game_init()の中で
			G.csvTable_EnemyAppear = csv_FromFile("data/enemyAppear.csv");
		を書いてください。

	（４）data/enemyAppear.csv を作成してください。
	
		（中身の例）
		NO,ID,Expl,REPEAT_CONTROL,REPEAT_LABEL,REPEAT_TIME,MOD_LEVEL,PROGRAM,WAIT,INTERVAL_BASE,INTERVAL_MAXHANDYCAP,NAME_FUNC,LIFE,X_MIN,X_MAX,Y_MIN,Y_MAX,SCORE_BASE,END
		int,string,string,string,,int,int,string,int,int,int,string,int,string,string,string,string,string,END
		-1,識別子,コメント,繰り返しの制御,繰り返しの名前,繰り返し回数。空白または-1は無限。,レベル5毎に出るなら「5」,「Boss」ならボス登場。,frame数,間隔frame（INTERVAL_BASEとINTERVAL_MAXHANDYCAPは両方設定すると有効）,間隔frame,関数（シーン）名,ライフ,出現位置x最左（ゲーム領域360px中、左辺を0とする）,出現位置x最右（ゲーム領域360px中、左辺を0とする）,出現位置y最上,出現位置y最下,スコア基礎点,END
		-1,,NO列は、1からの連番を途切れないようにしてください。,,,,,,,,,,,,,,,,END
		0,,NOが0の行は欠番。,,,,,,,,,,,,,,,,END
		1,,通常ザコ3セット（1セット4匹）,Begin,zako1,3,,,,,,,,,,,,,END
		2,,上から2匹。,,,,,,,,,zako,1,0,360,32,,SCOREBASE_ZAKO,END
		3,,,,,,,,,,,zako,1,0,360,32,,SCOREBASE_ZAKO,END
		4,,間隔,,,,,,,80,70,,,,,,,,END
		5,,左から,,,,,,,,,zako,1,0,,0,450,SCOREBASE_ZAKO,END
		6,,右から,,,,,,,,,zako,1,360,,0,450,SCOREBASE_ZAKO,END
		7,,間隔,,,,,,,80,70,,,,,,,,END
		8,,,End,zako1,,,,,,,,,,,,,,END
		9,,自機追尾は横から2匹沸く。2セット。,Begin,zako_homing1,2,,,,,,,,,,,,,END
		10,,左から,,,,,,,,,zako_homing,1,0,,0,360,SCOREBASE_ZAKOHOMING,END
		11,,,,,,,,,80,75,,,,,,,,END
		12,,右から,,,,,,,,,zako_homing,1,360,,0,360,SCOREBASE_ZAKOHOMING,END
		13,,,,,,,,,80,75,,,,,,,,END
		14,,,End,zako_homing1,,,,,,,,,,,,,,END
		15,,上からレーザー1匹。3セット。,Begin,zako_laser1,3,,,,,,,,,,,,,END
		16,,,,,,,,,,,zako_laser,40,0,360,32,,SCOREBASE_LAZER,END
		17,,間隔,,,,,,,120,115,,,,,,,,END
		18,,,End,zako_laser1,,,,,,,,,,,,,,END
		19,,Lv5毎にボス出現,,,,5,Boss,,,,boss,800,180,,1,,SCOREBASE_BOSS,END
		20,,,Finish,,,,,,,,,,,,,,,END
		EOF,,,,,,,,,,,,,,,,,,

	以上。


	書き方。data/enemyAppear.csv

	（１）概要

		このCSVファイルには、敵の出現パターンの１セットを設定します。
		ゲームは、この１セットの繰り返しです。
		１セット終わるとレベルが１増えます。

	（２）ループの開始と終了

		REPEAT_CONTROL  |  REPEAT_LABEL  |  REPEAT_TIME
		----------------+----------------+-------------
		Begin           |  zako1         |  3
		----------------+----------------+-------------
		    ～ここにループの内容を書く～
		----------------+----------------+-------------
		End             |  zako1         |

		Beginはループの始端行。名前（REPEAT_LABEL）を付けてEndと対応させる。
		Endはループの終端行。
		REPEAT_TIMEは繰り返し回数。

	（３）レベルを剰余
		MOD_LEVEL  |  PROGRAM
		-----------+-----------
		5          |  Boss

		現在レベルが５で割り切れる時にボスが出てくるという設定になります。

	（４）ウェイト
		WAIT  |
		------+--
		60    |

		60フレームの間隔を空けます。

	（５）インターバル
		INTERVAL_BASE  |  INTERVAL_MAXHANDYCAP
		---------------+------------------------
		80             |  70

		if 現在レベル*3 < INTERVAL_MAXHANDYCAP then
			wait( INTERVAL_BASE - math.floor(現在レベル*3) )
		else
			wait( INTERVAL_BASE - INTERVAL_MAXHANDYCAP )
		end
		という式になっています。

	（６）敵出現
		NAME_FUNC  |  LIFE  |  X_MIN  |  X_MAX  |  Y_MIN  |  Y_MAX  |  SCORE_BASE
		-----------+--------+---------+---------+---------+---------+------------------
		zako       |  1     |  0      |  360    |  32     |         |  SCOREBASE_ZAKO

		・NAME_FUNCは .lua で用意した関数名（シーン名）です。
		・LIFE は敵の耐久力です。
		・X_MIN、X_MAXは x座標です。ゲーム領域は、映像表示領域の左辺を0として、 0～360。
			X_MAXは省略できます。（空白または-1で省略扱い）
			X_MAXを記述すると、X_MIN～X_MAXの中でのランダム値になります。
		・Y_MIN、Y_MAXは y座標です。ゲーム領域は、映像表示領域の上辺を0として、 0～480。
			Y_MAXは省略できます。（空白または-1で省略扱い）
			Y_MAXを記述すると、Y_MIN～Y_MAXの中でのランダム値になります。
		・SCORE_BASEは、スコア計算の基礎値。
			SCORE_BASE * ( 現在レベル + 1 )
			定数は４つ。
				・SCOREBASE_ZAKO		 150
				・SCOREBASE_ZAKOHOMING	 100
				・SCOREBASE_LAZER		 700
				・SCOREBASE_BOSS		5000
			数値の直接入力もできます。

	（７）NO
		NO    |  ID
		------+------
		1     |

		NO列値が 1 から +1 続きでつながっている部分が有効です。
		途切れていると終了します。
		ID列は使いません。

	以上。

]]

--
function thread_enemy()
	
	wait( calc_intervalframe( 50, 25 ) )
	
	-- レベルは、リアルタイムに最新値を取得するために、毎回、関数を用います。

	-- リセット
	local number_EnemyAppear_CurrentNo = 1
	local numberTable_EnemyAppear_LoopCounts = {}
	local numberTable_EnemyAppear_LoopLimits = {}

	local hitsRecord
	hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )

	while(nil~=hitsRecord)do
		local repeatControl = hitsRecord["REPEAT_CONTROL"]
		local repeatLabel = hitsRecord["REPEAT_LABEL"]
		local repeatTime = hitsRecord["REPEAT_TIME"]
		
		if("Begin"==repeatControl)then
			numberTable_EnemyAppear_LoopCounts[repeatLabel] = 0
			numberTable_EnemyAppear_LoopLimits[repeatLabel] = tonumber(repeatTime)
			
			--NOを進め、次のレコードを読み取ります。
			number_EnemyAppear_CurrentNo = number_EnemyAppear_CurrentNo + 1
			hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
		elseif("End"==repeatControl)then
			--ループカウントを1増やす。
			numberTable_EnemyAppear_LoopCounts[repeatLabel] = numberTable_EnemyAppear_LoopCounts[repeatLabel] + 1
			if( numberTable_EnemyAppear_LoopCounts[repeatLabel] < numberTable_EnemyAppear_LoopLimits[repeatLabel] )then
				--カーソルを巻き戻してレコードを読み取り、さらにNOを進め、次のレコードを読み取ります。
				hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "REPEAT_LABEL", repeatLabel )
				number_EnemyAppear_CurrentNo = tonumber(hitsRecord["NO"]) + 1
				hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
			else
				--繰り返しを抜けます。
				--NOを進め、次のレコードを読み取ります。
				number_EnemyAppear_CurrentNo = number_EnemyAppear_CurrentNo + 1
				hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
			end
		else
			local modLevel = hitsRecord["MOD_LEVEL"]
			local executable = false
			if ( ""~=modLevel and "-1"~=modLevel ) then
				--MOD_LEVELに入力がある場合。
				if( mod(getLevel(),tonumber(modLevel))==0 )then
					--割り切れる場合のみ処理を実行。
					executable = true
				end
			else
				--MOD_LEVELが空欄または「-1」の場合。
				executable = true
			end

			if( executable )then
				local waitframe = hitsRecord["WAIT"]
				if( ""~=waitframe and "-1"~=waitframe )then
					--入力があれば
					wait( tonumber(waitframe) )
				end

				local intervalBase  = hitsRecord["INTERVAL_BASE"]
				local intervalMaxhandycap = hitsRecord["INTERVAL_MAXHANDYCAP"]
				if( ""~=intervalBase and "-1"~=intervalBase and ""~=intervalMaxhandycap and "-1"~=intervalMaxhandycap )then
					wait( calc_intervalframe( tonumber(intervalBase), tonumber(intervalMaxhandycap) ) )
				end
				
				local name_Func  = hitsRecord["NAME_FUNC"]
				if( ""~=name_Func and "-1"~=name_Func )then
					--敵出現
					local life  	= hitsRecord["LIFE"]
					local xMin  	= hitsRecord["X_MIN"]
					local xMax  	= hitsRecord["X_MAX"]
					local yMin  	= hitsRecord["Y_MIN"]
					local yMax  	= hitsRecord["Y_MAX"]
					local scoreBase = hitsRecord["SCORE_BASE"]
					
					local x, y
					if( ""~=xMax and "-1"~=xMax )then
						--最大値の入力があれば
						x = GAME_LEFT + randMT( tonumber(xMin), tonumber(xMax) )
					else
						x = GAME_LEFT + tonumber(xMin)
					end

					if( ""~=yMax and "-1"~=yMax )then
						--最大値の入力があれば
						y = randMT( tonumber(yMin), tonumber(yMax) )
					else
						y = tonumber(yMin)
					end
					
					if( "SCOREBASE_ZAKO" == scoreBase)then
						scoreBase = SCOREBASE_ZAKO
					elseif( "SCOREBASE_ZAKOHOMING" == scoreBase)then
						scoreBase = SCOREBASE_ZAKOHOMING
					elseif( "SCOREBASE_LAZER" == scoreBase)then
						scoreBase = SCOREBASE_LAZER
					elseif( "SCOREBASE_BOSS" == scoreBase)then
						scoreBase = SCOREBASE_BOSS
					else
						scoreBase = tonumber(scoreBase)
					end
					
					createEnemy( G.suika_walkdown[1], x, y, life, scoreBase*(getLevel()+1), name_Func )
				end
			
				local program = hitsRecord["PROGRAM"]
				if( "Boss"==program )then
					--ボスの処理をする。
					wait(1)
					for i = 1,calc_intervalframe( 30, 25 ),1 do -- ボスの為に最大何秒スレッドを待たせるか。ボスが撃破されたら次に移る。
						if isAlive(A.boss) then
							wait(60)
						end
					end
					BOSS_PATTERN = BOSS_PATTERN + 1 -- ボスパターン増加
				end
			end
			
			--NOを進め、次のレコードを読み取ります。
			number_EnemyAppear_CurrentNo = number_EnemyAppear_CurrentNo + 1
			hitsRecord = csv_SelectRecord( G.csvTable_EnemyAppear, "NO", number_EnemyAppear_CurrentNo )
		end
	end


	-- 敵スレッド1ループ毎の処理
	setgv(0,1,getLevel()+1) -- LEVEL増加
	SCORE_SHOTHIT = 10*getLevel() -- 次レベルの打ち込み点増加
	if( mod(getLevel(),10)==1 )then
		local idx = 1 + mod(math.floor(getLevel()/10),3);
		addMover( A.bg,  0, 16, MOVER_ADDALPHA, -16 );
		addMover( A.bg, 16,  1, MOVER_SETFACE,  G.game.bg[idx] );
		addMover( A.bg, 16, 16, MOVER_ADDALPHA,  16 );
	end
end

--[[
	敵の出現間隔(frame)。
	level: 現在レベルが入る。
	limit: 減少の限界値。
]]
function calc_intervalframe( frame_base, limit)
	local rank_inc = 3
	local level = getLevel()
	if level*rank_inc < limit then
		return frame_base - math.floor(level*rank_inc)
	else
		return frame_base - limit
	end
end

--【/改変】このファイルは新規に追加。A.I.M.Sサンプル『suica32』の
--「s/chr/enemy_gen.lua」を元に改変した。
