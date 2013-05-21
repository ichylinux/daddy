# language: ja

機能: ユーザとキャリアを紐付ける

　現状は、メニューからキャリアをクリックすると、ログインユーザに関係なくすべて
のキャリアが一覧表示される。実際は、ユーザとキャリアを１対１の関係である。

　ユーザとキャリアを１対１の関係に修正する。既存データについてはユーザとキャリ
アの紐付けがないので、マイグレーション時に自動更新できない。キャリアを論理削除
しておき、必要なデータのみSE対応する。

シナリオ: 本来はユーザに関する属性をユーザテーブルに追加

  * rails g migration add_column_last_name_on_users
  * rails g migration add_column_first_name_on_users
  * rails g migration add_column_gender_on_users
  * rails g migration add_column_birthday_on_users

シナリオ: キャリアの論理削除フラグを追加

  * rails g migration add_column_deleted_on_careers

シナリオ: キャリアからユーザに関する属性を削除
　キャリアからユーザに関する属性を削除して、代わりにユーザIDを追加する。

  * rails g migration remove_column_last_name_on_careers
  * rails g migration remove_column_first_name_on_careers
  * rails g migration remove_column_gender_on_careers
  * rails g migration remove_column_birthday_on_careers
  * rails g migration add_column_user_id_on_careers

シナリオ: キャリアとユーザの紐付け
　ユーザはDevise関係の制御が入っているため、マスアサインの指定がホワイト
リスト形式になっている。ユーザに移動した属性をマスアサインできるようにする。

  * キャリアとユーザの紐付け

シナリオ: 既存のキャリアを論理削除

  * rails g migration delete_careers

シナリオ: マイグレーション

  * rake db:migrate
