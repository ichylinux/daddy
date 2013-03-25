# language: ja

機能:

シナリオ: トップ画面にキャリアへのリンクを用意
  * ヘッダを作成
  * レイアウトにヘッダを挿入

シナリオ: 今までの経歴を登録できるように
  * rails g model career_detail
  * rake db:migrate
  * view を修正
  * controller を修正
