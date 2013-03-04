# language: ja

機能: 新規プロジェクト作成

　ここでは、サンプルプロジェクトとして業務経験・スキル管理サイト「careerlife」を作成する。

  シナリオ: アプリのひな形を生成
    もし 以下のコマンドを実行する
    | rails new careerlife -d mysql |
    ならば 新しいアプリのひな形が生成される

  シナリオ: Gemfile を編集
    前提 アプリのひな形が生成されている
    もし Gemfile に以下の gem を定義する
    | execjs |
    | therubyracer |
    かつ 以下のコマンドを実行する
    | sudo bundle install |
    ならば Gemfile.lock が更新される
    
  シナリオ: サーバを起動
    前提 Gemfile の編集が完了している
    もし 以下のコマンドを実行する
    | rails s |
    ならば WEBrickサーバが起動する
    