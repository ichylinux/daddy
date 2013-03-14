# language: ja

機能:

シナリオ: キャリアの登録画面を作成

* rails g scaffold career name:string birthday:date gender:string
"""
　rails の scaffold の機能を利用することでCRUD画面を自動生成できます。
"""
* rake db:migrate
