# language: ja

機能: 基本操作

シナリオ: CRUD

* トップページを表示
* キャリアを登録する をクリック
* ログインに遷移
* アカウント作成 をクリック
* メールアドレス に daddy@example.com と入力
* パスワード に daddydaddy と入力
* パスワード（確認用） に daddydaddy と入力
* 登録する をクリック
* キャリアの一覧に遷移
* 追加 をクリック
* 姓 に 鈴木 と入力
* 名 に 一郎 と入力
* 性別 に 男性 を選ぶ
* 紹介文 に以下の文章を入力
"""
はじめまして
Railsはじめました。
"""
* 登録する をクリック
* キャリアの参照に遷移

* 編集 をクリック
* 姓 に 佐藤 と入力
* 名 に 花子 と入力
* 性別 に 女性 を選ぶ

* 紹介文 に以下の文章を入力
"""
はじめまして
Railsはじめました。
Javaに自信あります。
"""

* 経歴を追加 を 3 回クリック
* 経歴の入力欄が 3 つ表示される
* 経歴に以下の内容を入力する
| プロジェクト名 | 開始日     | 終了日     |
| 某案件１      | 2012-04-01 | 2012-06-30 |
| 某案件２      | 2012-07-01 | 2012-12-31 |
| 某案件３      | 2013-01-01 |            |

* 更新する をクリック
* キャリアの参照に遷移

* 戻る をクリック
* キャリアの一覧に遷移

* キャリア一覧の 太郎 の 削除 をクリック
* キャリアが削除され、一覧に遷移

