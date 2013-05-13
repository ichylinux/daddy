# language: ja

機能: ユーザとキャリアを紐付ける

　現状は、メニューからキャリアをクリックすると、ログインユーザに関係なくすべて
のキャリアが一覧表示される。実際は、ユーザとキャリアを１対１の関係である。

　ユーザとキャリアを１対１の関係に修正し、キャリアから一覧画面を廃止する。

　既存データはユーザとキャリアの紐付けがないので、マイグレーション時に自動更新
できない。キャリアを論理削除しておき、必要なデータのみSE対応する。

シナリオ: 本来はユーザに関する属性をユーザテーブルに追加

  * rails g migration add_column_last_name_on_users
  * rails g migration add_column_first_name_on_users
  * rails g migration add_column_gender_on_users
  * rails g migration add_column_birthday_on_users

シナリオ: キャリアの論理削除フラグを追加

  * rails g migration add_column_deleted_on_careers

シナリオ: キャリアからユーザに関する属性を削除

  * rails g migration remove_column_last_name_on_users
  * rails g migration remove_column_first_name_on_users
  * rails g migration remove_column_gender_on_users
  * rails g migration remove_column_birthday_on_users

シナリオ: マイグレーション実行

  * rake db:migrate
