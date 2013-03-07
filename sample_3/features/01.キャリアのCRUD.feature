# language: ja

機能:

シナリオ: scaffold

* rails g scaffold career name:string birthday:date gender:string
"""
　rails の scaffold の機能を利用することでCRUD画面を自動生成できます。
"""
* rake db:migrate
* キャリアを表示
* New Career をクリック
* Name に 鈴木 と入力
* Gender に M と入力
* Create Career をクリック
* キャリアの参照に遷移
* Edit をクリック
* Name に 佐藤 と入力
* Update Career をクリック
* キャリアの参照に遷移
* Back をクリック
* キャリアの一覧に遷移
