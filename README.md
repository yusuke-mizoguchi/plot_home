# プロットフォーム(plot_form)
# サービス概要
こんな話を思いついたけど、という時に
小説のプロットや一部文章を投稿し
他人に批評してもらうサービスです。

## メインターゲット
- 小説を書いている人
- 設定資料などが好きな読者

## ユーザーが抱える課題
- 作品を作っている際、文量が多くなる程中弛みしてしまう。
- 自分は知らなかった作品との設定被り等。
- 小説投稿サイトはあっても、その前段階のサイトがない。匿名掲示板やSNSに頼っている状況。

## 解決方法
- 途中の文章を批評してもらうことでモチベーションを維持する。
- 違う視点を持つ人や作品に触れてきた人に指摘してもらえる。
- 小説を批評「し合う」ことを推奨する場所を作る。

## 実装予定の機能
### 仮リリース
- ゲストログイン機能
　→ゲスト時は閲覧のみ。投稿やコメント機能は登録必須
　→ゲストログインではなく、未ログイン時に制限を設ける
- 公開範囲の指定(創作側、読者側、ゲスト)
- 批評(コメント)機能

### 本リリース
- トップページに直近で批評したユーザーを数人表示
- 自身の投稿に批評がついた際に通知
- 文量(長編・中編・短編)、ジャンル、ユーザー名による検索機能
　→フリーワードはactiontextの関係で今回はなし
- 作品投稿時に画像も添付できるように

## なぜこのサービスを作りたいのか
小説を書き進めていくうちに、途中で設定の破綻や話の流れに無理があると分かることがある。
途中で修正できる程度ならまだしも、１からやりなおす場合もある。
プロット段階から批評してもらうことができれば、上記のような事態に陥る確率を減らすことができる。
また、そうでなくても他人からの批評・意見を取り入れることで、より良い作品を作ることができる。

現状、小説を投稿するサイト、投稿した小説を批評してもらうサイトはあるが、
プロット段階から批評を受けられる場所はなく、現状は個人ブログをSNSで共有するか、匿名掲示板を用いている人が多い。
SNSや匿名掲示板では使用目的が多岐に渡り、かえって人が集まり辛い面があるので、目的を絞った場所を作りたい。

## スケジュール
- README 2/9
- 画面遷移図 2/13
- ER図・テーブル設計 2/21
- メイン機能実装・仮リリース 4/11
- 本リリース 4/30〆

## 画面遷移図
　https://www.figma.com/file/RL7Dxn3pC6FwoH9WpR9ynS/%E3%83%9D%E3%83%BC%E3%83%88%E3%83%95%E3%82%A9%E3%83%AA%E3%82%AA%2F%E3%83%97%E3%83%AD%E3%83%83%E3%83%88%E3%83%95%E3%82%A9%E3%83%BC%E3%83%A0

## ER図の追加
　https://drive.google.com/file/d/1EqBOf7rewOne-x5NvPVB3I4FRfVapMbZ/view?usp=sharing
