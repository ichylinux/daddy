# coding: UTF-8

require 'rake'

namespace :dad do
  
  desc '開発日記を実行します。'
  task :diary do
    system("bundle exec rake dad:cucumber DRIVER=poltergeist COVERAGE=false features/開発日記")
  end
  
  namespace :diary do
    desc '本日用の開発日記を準備します。'
    task :new do
      today = Date.today.strftime('%Y-%m-%d')
  
      system("rake dad:cucumber:install")
  
      today = Date.today.strftime('%Y-%m-%d')
  
      feature = "features/開発日記/#{today}.feature"
      unless File.exist?(feature)
        system("echo '# language: ja'            >  #{feature}")
        system("echo                             >> #{feature}")
        system("echo '機能:'                         >> #{feature}")
        system("echo                             >> #{feature}")
      end
  
      step = "features/step_definitions/開発日記/#{today}.rb"
      unless File.exist?(step)
        system("echo '# coding: UTF-8'            >  #{step}")
        system("echo                              >> #{step}")
      end
    end
  end
end
