*はじめに(Introduction)

ライセンスについては、一番上の階層の README.md を見てください。
CSVは dataフォルダーの中にあります。


*敵の出現パターンを編集可能にします。

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







このアプリケーションの説明は 『ゼノンツールズＷｉｋｉ』 http://xenon.wiki.fc2.com/ をご覧ください。
Web site: http://xenon.wiki.fc2.com/

* メモ(Self Note). これはMarkdown形式のファイルです。 This file is .md(Markdown) file.
* メモ(Self Note). UTF-8(BOM有)で保存すること。 I save by encoding UTF-8.
* メモ(Self Note). ファイル名に [ ] を使うとコミットできない。 Don't write filename "[" "]".commit failure.
* メモ(Self Note). 拡張子「.md」はMarkdownというテキスト形式。 Extensions ".md" is Markdown file.
