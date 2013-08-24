# language: ja

機能:

シナリオ: ログイン機能
  * Gemfileを編集
  * sudo bundle install
  * rails g devise:install
  * development.rb を編集
  * rails g devise user
  * rake db:migrate
  * devise用の日本語ファイルを取得

シナリオ: キャリアの登録はログインしないとできないように
  * コントローラを修正

シナリオ: ログアウトを用意
  * ヘッダを修正

シナリオ: ログインを日本語化
  * rails g devise:views
