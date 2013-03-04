# coding: UTF-8

前提(/^プロジェクトの作成場所である ワークスペース で、以下のコマンドを実行する$/) do |table|
  commands = table.raw[1..-1]
  commands.each do |c|
    system "cd .. && rails new sample_1 -d mysql --force"
  end
end

ならば(/^新しいアプリのひな形が生成される$/) do
  
end
