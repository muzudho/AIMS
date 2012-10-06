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
		NO,SCENE,Expl,BTN1,BTN2,BTN3,BTN4,BTN5,BTN6,BTN7,BTN8,BTN9,BTN10,BTN11,BTN12,END
		int,int,string,int,int,int,int,int,int,int,int,int,int,int,int,END
		-1,シーン名。空白または「-1」を入れると無視されます。,解説,ボタン1を押したときの移動先シーン名。空白または「-1」を入れると無視されます。,ボタン2,ボタン3,ボタン4,ボタン5,ボタン6,ボタン7,ボタン8,ボタン9,ボタン10,ボタン11,ボタン12,END
		-1,,"Sorry, Encoding of this csv file is Shift-JIS.（このCSVファイルはShift-JISエンコーディングです。）",,,,,,,,,,,,,END
		0,scene1,,,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		1,scene2,,scene1,,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		2,scene3,,scene1,scene2,,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		3,scene4,,scene1,scene2,scene3,,scene5,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		4,scene5,,scene1,scene2,scene3,scene4,,scene6,scene7,scene8,scene9,scene10,scene11,scene12,END
		5,scene6,,scene1,scene2,scene3,scene4,scene5,,scene7,scene8,scene9,scene10,scene11,scene12,END
		6,scene7,,scene1,scene2,scene3,scene4,scene5,scene6,,scene8,scene9,scene10,scene11,scene12,END
		7,scene8,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,,scene9,scene10,scene11,scene12,END
		8,scene9,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,,scene10,scene11,scene12,END
		9,scene10,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,,scene11,scene12,END
		10,scene11,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,,scene12,END
		11,scene12,,scene1,scene2,scene3,scene4,scene5,scene6,scene7,scene8,scene9,scene10,scene11,,END
		EOF,,,,,,,,,,,,,,,

	（３）シーンの _OnStep の最後で、次の関数を呼び出します。

		auto_ForwardScene("scene1");	--引数は自シーン名。

	これで、押したボタンに応じて changeScene します。
	以上。






このアプリケーションの説明は 『ゼノンツールズＷｉｋｉ』 http://xenon.wiki.fc2.com/ をご覧ください。
Web site: http://xenon.wiki.fc2.com/

* メモ(Self Note). これはMarkdown形式のファイルです。 This file is .md(Markdown) file.
* メモ(Self Note). UTF-8(BOM有)で保存すること。 I save by encoding UTF-8.
* メモ(Self Note). ファイル名に [ ] を使うとコミットできない。 Don't write filename "[" "]".commit failure.
* メモ(Self Note). 拡張子「.md」はMarkdownというテキスト形式。 Extensions ".md" is Markdown file.
