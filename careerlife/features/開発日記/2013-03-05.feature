# language: ja

機能: 新規プロジェクト作成

サンプルプロジェクトとして業務経験・スキル管理サイト「careerlife」を作成します。
まずは、エンジニアが経歴を登録することができ、人材を必要としている顧客が、必要とする
スキル・経験を持つエンジニアを検索することができるまでの開発を目指します。

シナリオ: アプリのひな形を生成し、Railsの動作確認ができるまで
* rails new careerlife -d mysql
* Gemfile に以下の gem を定義
| daddy |
| execjs |
| therubyracer |
* sudo bundle install
* rake dad:db:config
* rails s
* ブラウザ http://localhost:3000 にアクセス

