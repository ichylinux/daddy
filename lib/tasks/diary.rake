# coding: UTF-8

require 'rake'

namespace :dad do
  
  desc '開発日記を実行します。'
  task :diary do
    features_path = File.join('features', '開発日記')
    driver = ENV['DRIVER'] || 'poltergeist'
    system("bundle exec rake dad:cucumber DRIVER=#{driver} COVERAGE=false #{features_path}")
  end
  
  namespace :diary do
    desc '本日用の開発日記を準備します。'
    task :new do
      today = Date.today.strftime('%Y-%m-%d')
  
      Rake::Task['dad:cucumber:install'].invoke
  
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

    desc '開発日記を削除します。'
    task :destroy do
      Dir[File.join('features', '開発日記', '*.feature')].each do |file|
        puts "#{file} を削除します。"
        FileUtils.rm_f(file)
      end
      Dir[File.join('features', 'step_definitions', '開発日記', '*.rb')].each do |file|
        puts "#{file} を削除します。"
        FileUtils.rm_f(file)
      end
    end
  end
end
