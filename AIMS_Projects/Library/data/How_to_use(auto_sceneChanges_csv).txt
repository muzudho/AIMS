（１）
シーン切替をする場所では、changeScene(～)を書くのではなく、
auto_SceneAt(～)と書きます。

	auto_SceneAt( id )

	id: auto_sceneChanges.csvのID列値。


（２）
auto_sceneChanges.csv の Expl列は、コメントを書くのに使える欄です。


（３）
必ず画面遷移する場合は、 ALWAYS列に、シーン名を書いてください。


（４）
データロード中（Now loading...）中に、「ボタンを押したときのシーン切替」を
無効にしたい場合は、DISABLED_AT_LOADING列に「Yes」と書いてください。
（「Yes」の大文字・小文字は区別します。半角で記入。前後に余計な空白も入れないで
ください）


（５）
スレッドが終了しているとき、「ボタンを押したときのシーン切替」よりも先に
有効にしたいシーン切替がある場合は、THREAD_NOT_RUNNING列にシーン名を入れて
ください。


（６）
「論理ボタン１」を押したときにシーン切替したい場合は、
BTN1列にシーン名を入れてください。
BTN1_PARAM列に「Push」と記入すると、ボタンが押しっぱなしの場合は反応させず、
一度離してから押したときに反応します。（OnStepで利用する場合などに利用します）

BTN2, BTN2_PARAM ～ BTN12, BTN12_PARAM も同じです。


以上