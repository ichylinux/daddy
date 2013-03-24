# coding: UTF-8

require 'rake'

namespace :dad do
  
  desc '本日用の日記を準備します。'
  task :diary do
    today = Date.today.strftime('%Y-%m-%d')

    system("rake dad:cucumber:install")

    today = Date.today.strftime('%Y-%m-%d')

    feature = "features/開発日記/#{today}.feature"
    if File.exist?(feature)
      puts "すでに #{feature} が存在します。上書きはしません。"
    else
      system("echo '# language: ja'            >  #{feature}")
      system("echo                             >> #{feature}")
      system("echo '機能:'                         >> #{feature}")
      system("echo                             >> #{feature}")
    end

    step = "features/step_definitions/開発日記/#{today}.rb"
    if File.exist?(step)
      puts "すでに #{step} が存在します。上書きはしません。"
    else
      system("echo '# coding: UTF-8'            >  #{step}")
      system("echo                              >> #{step}")
    end
  end
end
