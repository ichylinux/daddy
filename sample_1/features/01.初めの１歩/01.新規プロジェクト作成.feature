# language: ja

機能: 新規プロジェクト作成

　ここでは、サンプルプロジェクトとして業務経験・スキル管理サイト「careerlife」を作成する。

  シナリオ: アプリのひな形を生成
    もし プロジェクトの作成場所である ワークスペース で、以下のコマンドを実行する

    | cd [ワークスペース]              |
    | rails new careerlife -d mysql |

    ならば 新しいアプリのひな形が生成される
