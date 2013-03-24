# language: ja

機能: 新規プロジェクト作成

サンプルプロジェクトとして業務経験・スキル管理サイト「careerlife」を作成します。
エンジニアが経歴を登録し、トップページで検索できるまでの開発を目指します。

シナリオ: アプリのひな形を生成し、Railsの動作確認ができるまで
  * rails new careerlife -d mysql --skip-bundle
  * Gemfile に以下の gem を定義
    | daddy  | Railsアプリ開発をサポートするユーティリティ |
    | execjs | RubyからJavaScriptの実行を可能にする |
    | therubyracer | ExecJS が利用するJavaScript実行環境。Chromeが搭載しているV8 Engineを利用。 |
  * sudo bundle install
  * rake dad:db:config
  * rake dad:db:create
  * rake db:migrate
  * rails s
  * ブラウザで http://localhost:3000 にアクセス

