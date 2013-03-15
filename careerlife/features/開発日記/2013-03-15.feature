# language: ja

機能:

シナリオ: devise のインストール
* rails g devise:install
* development.rb を編集
"""
config.action_mailer.default_url_options = { :host => 'localhost:3000' }
"""
* rails g devise user
* rake db:migrate
* devise 用の日本語ファイルを取得

シナリオ: キャリアの登録はログインしないとできないように
* before_filter :authenticate_user!

シナリオ: ログアウトを用意

シナリオ: ログインを日本語化
* rails g devise:views
