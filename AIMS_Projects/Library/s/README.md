*はじめに(Introduction)

ライセンスについては、一番上の階層の README.md を見て下さい。


*シーン移動を自動化します。

	使い方。

	（１）Luaファイルを読み込んでおきます。
		prequire("s/csv.lua");
		prequire("s/auto.lua");
		--その他、シーンファイル。

	（２）シーン遷移CSVを作成します。

		data/sceneChanges.csv

		（例）
		NO,ID,Expl,ALWAYS,DISABLED_AT_LOADING,THREAD_NOT_RUNNING,BTN1,BTN1_PARAM,BTN2,BTN2_PARAM,BTN3,BTN3_PARAM,BTN4,BTN4_PARAM,BTN5,BTN5_PARAM,BTN6,BTN6_PARAM,BTN7,BTN7_PARAM,BTN8,BTN8_PARAM,BTN9,BTN_PARAM,BTN10,BTN10_PARAM,BTN11,BTN11_PARAM,BTN12,BTN12_PARAM,END
		int,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,string,END
		-1,auto_ForwardScene(...)が置かれている関数名を入れると便利です。識別できれば何でも構わない。空白または「-1」を入れると無視されます。,解説,この列に設定されていると、必ずこれが選ばれます。,「Yes」…isLoaderRunning=true （データロード中）の場合、ボタン入力によるシーン遷移を無効にします。「No、-1、(空白)」…なにもしません。,isThreadRunning()==false（スレッドが終了している）の場合、ボタンよりも優先的にこれが選ばれます。（空白、または-1以外が設定されている場合）,ボタン1を押したときの移動先シーン名。空白または「-1」を入れると無視されます。,「Push」…一度ボタンを離してから押さないと反応しません。「(空白)または-1」…押していれば反応します。,ボタン2,ボタン2,ボタン3,ボタン3,ボタン4,ボタン4,ボタン5,ボタン5,ボタン6,ボタン6,ボタン7,ボタン7,ボタン8,ボタン8,ボタン9,ボタン9,ボタン10,ボタン10,ボタン11,ボタン11,ボタン12,ボタン12,END
		-1,,"Sorry, Encoding of this csv file is Shift-JIS.（このCSVファイルはShift-JISエンコーディングです。）",,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		0,boot_OnStart,,logo,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		1,logo_OnStep(DONT_USE),CSVファイルが読込み完了していないことがあるので、このレコードは使えない。,,Yes,title,title,,,,,,,,,,,,,,,,,,,,,,,,END
		2,title_OnStep,,,,,game,Push,,,,,,,,,,,,,,,,,,,,,,,END
		3,thread_gameover,,gameover,,,,,,,,,,,,,,,,,,,,,,,,,,,END
		4,gameover_OnStep,,,,,title,,,,,,,,,,,,,,,,,,,,,,,,END
		EOF,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

	（３）シーンを切り替えたいタイミングで、次の関数を呼び出します。

		auto_ForwardScene("scene1_OnStep");	--引数は、これを呼び出している関数の名前を入れると便利。

	これで、押したボタンに応じて changeScene します。
	以上。






このアプリケーションの説明は 『ゼノンツールズＷｉｋｉ』 http://xenon.wiki.fc2.com/ をご覧ください。
Web site: http://xenon.wiki.fc2.com/

* メモ(Self Note). これはMarkdown形式のファイルです。 This file is .md(Markdown) file.
* メモ(Self Note). UTF-8(BOM有)で保存すること。 I save by encoding UTF-8.
* メモ(Self Note). ファイル名に [ ] を使うとコミットできない。 Don't write filename "[" "]".commit failure.
* メモ(Self Note). 拡張子「.md」はMarkdownというテキスト形式。 Extensions ".md" is Markdown file.
