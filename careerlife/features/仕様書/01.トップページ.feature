# language: ja

機能:

シナリオ: トップページを表示する

  * トップページを表示

シナリオ: ログイン

  前提 メールアドレス user1@example.com が存在する
  前提 トップページを表示

  * ログイン をクリック
  * ログインに遷移
  * メールアドレス に user1@example.com と入力
  * パスワード に testtest と入力
  * ログイン をクリック
  * トップページに遷移
