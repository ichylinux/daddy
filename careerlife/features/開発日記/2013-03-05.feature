# language: ja

機能: 新規プロジェクト作成

サンプルプロジェクトとして業務経験・スキル管理サイト「careerlife」を
作成します。

シナリオ: Railsアプリを新規作成

  * rails new careerlife -d mysql
  
シナリオ: ライブラリをインストール

以下のライブラリをインストールします。

daddy        ・・・ Railsアプリ開発をサポートするユーティリティ
execjs       ・・・ RubyからJavaScriptの実行を可能にする
therubyracer ・・・ ExecJS が利用するJavaScript実行環境。Chromeが搭載しているV8 Engineを利用。
unicorn      ・・・ アプリケーションサーバ

  * Gemfileを編集
  * sudo bundle install

シナリオ: Daddyをインストール

  * rake dad:install

シナリオ: Unicornをインストール

  * rake dad:unicorn:install
  
シナリオ: Nginxをインストール

  * rake dad:nginx:install

シナリオ: データベースを作成

  * rake dad:db:config
  * rake dad:db:create
  * rake db:migrate

シナリオ: アプリを機動

  * sudo service nginx start
  * sudo service unicorn start
  * ブラウザで http://localhost にアクセス

