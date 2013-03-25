# language: ja

機能:

シナリオ: キャリアの登録画面を作成
  * rails g scaffold career last_name:string first_name:string birthday:date gender:string
  * rake db:migrate
