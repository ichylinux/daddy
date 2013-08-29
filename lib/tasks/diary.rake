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
  
      feature = "features/開発日記/#{today}.feature"
      unless File.exist?(feature)
        File.write feature, <<-EOF
# language: ja

機能:

        EOF
      end
  
      step = "features/step_definitions/開発日記/#{today}.rb"
      unless File.exist?(step)
        File.write step, <<-EOF
# coding: UTF-8

        EOF
      end
    end
  end
end
