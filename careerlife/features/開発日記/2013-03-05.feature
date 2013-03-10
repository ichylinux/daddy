# language: ja

機能: 新規プロジェクト作成

サンプルプロジェクトとして業務経験・スキル管理サイト「careerlife」を作成します。
まずは、エンジニアが経歴を登録することができ、人材を必要としている顧客が、必要とする
スキル・経験を持つエンジニアを検索することができるまでの開発を目指します。

シナリオ: アプリのひな形を生成し、Railsの動作確認ができるまで
* 以下のコマンドを実行します。
| rails new careerlife -d mysql |
* 新しいアプリのひな形が生成されます。
* database.yml を編集

シナリオ: Gemfile を編集
* アプリのひな形が生成されている
* Gemfile に以下の gem を定義します。
| daddy |
| execjs |
| therubyracer |
* 以下のコマンドを実行します。
| sudo bundle install |
* Gemfile.lock が更新されます。
  
シナリオ: サーバを起動
* Gemfile の編集が完了している
* 以下のコマンドを実行します。
| rails s |
* WEBrickサーバが起動します。
    