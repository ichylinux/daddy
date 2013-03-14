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
* wget https://gist.github.com/kawamoto/4729292/raw/ec2b3e23be61b4b8f6903efedff359fd0a4b3223/devise.ja.yml -O config/locales/devise.ja.yml

シナリオ: キャリアの登録はログインしないとできないように
* before_filter :authenticate_user!
* ログアウトを用意

シナリオ: ログインを日本語化
* rails g devise:views
