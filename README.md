# Converts Bookshare's .brf braille file to Unicode braille with markdown markup - Bookshareの.brf点字ファイル(ASCII点字)を、ユニコード点字のmarkdownテキストファイルに変換するperlスクリプト

## in English

### What is this?

This perl scripts converts Bookshare's braille file(.brf) to Unicode braille(like ⠠⠃⠕⠕⠅⠎⠓⠁⠗⠑), which can be displayed with refreshable braille display using screen readers like NVDA or iOS/Mac VoiceOver. 

It also adds markdown's heading(#) and list(*) mark to the Unicode braille text file so that you can navigate through the braille file as html file using screen reader's navigate commands.

### Usage

Type following in Windows' command prompt:

> brf2md.exe some_book.brf

This outputs some-book.brf.md.

You can read this Unicode braille markdown file with markdown preview apps like "Byword" or "Editorial Pro".

## 何をするものか

iPhoneのアクセシビリティ機能のVoiceOverに対応する点字ディスプレイで、 [Bookshare](https://www.bookshare.org/cms/) の**点字データ**を読みやすくするための変換スクリプトです。

「⠁⠃⠉⠯」のようなユニコード点字に変換し、それをhtml形式で表示できるようにmarkdownの記号を加えています。

Bookshareの.brfファイルでは原本のページの切れ目に「------23」のように連続したハイフンがあるので、その行をmarkdownの箇条書きの記号「*」を入れて、VoiceOverのローターの箇条書きの移動でページを切り替えられるようにしています。

半角スペースが4つあるところにmarkdownの見出し記号「#」を入れています。VoiceOverのローターの見出しの移動で前後の見出しへ移動できます。(本によって、スペース2マスで見出しになっていたり、４マスあっても見出しではない場合もありますが。)

## 変換の仕方

Windowsのコマンドプロンプトで:

> brf2md.exe sample.brf

のように変換したい.brfファイルを指定すると、sample.brf.mdというファイルが出力されます。

brf2md.exeのショートカットを「送る」メニューに登録して変換することもできます。

## ユニコード点字のmarkdownファイルの読み方

Windowsの場合はpandocで変換してブラウザで読むことができます。

iOSの場合はmarkdownファイルをhtmlとしてプレビューできるアプリが必要です。

「Edhita」は無料ですが、広告がわずらわしいので、「Editorial Pro」を私は購入しました。

「Byword」は [AppleVis](http://www.applevis.com/) にレビューもあり、フォルダを作ってのファイル管理ができてとても使いやすいのですが、Bookshareの.brfファイルを変換したものを読み込むとファイルサイズが大きすぎるためか、アプリが落ちて使えません。「Editorial Pro」では読み込んで表示することができます。

- [無料・広告付き - ‎Edhita: Text Editor on the App Store](https://itunes.apple.com/us/app/edhita-text-editor/id398896655?mt=8)
- [120円 - (Edhitaの広告無しの有料版) ‎「Editorial Pro」をApp Storeで](https://www.google.com/search?source=hp&ei=JJZSW8vrEsKu0AT-sZjwBQ&q=Zuogen+Zhang+editorial+pro+%E3%82%A2%E3%83%97%E3%83%AA&oq=Zuogen+Zhang+editorial+pro+%E3%82%A2%E3%83%97%E3%83%AA&gs_l=psy-ab.3...1013.8973.0.9597.22.22.0.0.0.0.151.2303.6j15.21.0....0...1c.1j4.64.psy-ab..1.7.800...0i10i30k1j33i21k1.0._1SdWy5FmhA)
- [720円 ‎「Byword」をApp Storeで](https://itunes.apple.com/jp/app/byword/id482063361?mt=8)
- [いつの間にかByword神がかってた - /]()
- [Byword | AppleVis](https://www.applevis.com/apps/ios/productivity/byword)

## 動作環境・使用上の注意

.plのスクリプトは、Strawberry perlのポータブル版で実行できます。

または.exe版はperlが組み込まれているので単体で使用できます。

- [Strawberry Perl for Windows - Releases](http://strawberryperl.com/releases.html)

.plのスクリプトの実行にはperlのポータブル版以外に、Convert::Brailleモジュールのインストールとその修正が必要です。(.exe版には修正されたbraille.pmが入っています。)

portableshell.batを実行後、次のようにしてモジュールをインストールします。

> cpan Convert::Braille

インストール後に下記の場所にあるBraille.pmを、 [私の別のリポジトリにあるbraille.pm](https://github.com/brlat/Convert-Braille-patch) と置き換えます。

> ./perl/site/lib/Convert/Braille.pm

## 使い方

brl2utf8.exeはコマンドプロンプトで

> brl2utf8 input.brf

とすると実行できます。

または「送る」メニューに登録したり、「プログラムから開く」で実行できます。

brl2utf8.plはperlが実行できる状態で、下記のようにすると変換ができます。

> perl brl2utf8.pl input.brf

小文字NABCCの.brlファイルや.bseファイルも変換できます。ただしヘッダ部分やページの扱いなどはうまく変換できません。

## PAR::Packerモジュールで.exeファイルに変換

perlが実行できる状態で、次のようにしてモジュールをインストール。-forceオプションをつけないとエラーが出る。

> cpanm PAR::Packer --force

これで.plスクリプトを.exeに変換するppコマンドが使えるようになる。

次のようにして変換を実行する。-uオプションをつけないとutf8_heavy.plが読み込めないというエラーが出ます。下記のようにしてperlスクリプトを.exeに変換しました。

> pp -u -o brl2utf8.exe brl2utf8.pl

このようにしてできた.exeファイルは、実行する度にテンポラリファイルが書き込まれるので、定期的に手動で削除しないと一時ファイルが増え続けてしまう。

一時ファイルが保存される場所は:

> C:/Users/アカウント名/appdata/local/temp/par-4e4543

## 参考サイト

- [Bug #119856 for PAR-Packer: pp-generated exe cannot locate utf8_heavy.pl](https://rt.cpan.org/Public/Bug/Display.html?id=119856)
- [Strawberry Perl(Portable)でPerlスクリプトのexeファイル化 | ビビビッ](https://vivibit.net/strawberryperl2exe/)

## 著作権

perlと同じです。

