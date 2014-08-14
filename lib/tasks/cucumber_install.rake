require 'rake'

namespace :dad do
  namespace :cucumber do
    task :install do
      FileUtils.mkdir_p("features")
      
      FileUtils.mkdir_p("features/step_definitions")
      FileUtils.touch("features/step_definitions/.keep")
      FileUtils.mkdir_p("features/step_definitions/開発日記")
      FileUtils.touch("features/step_definitions/開発日記/.keep")
      FileUtils.mkdir_p("features/step_definitions/仕様書")
      FileUtils.touch("features/step_definitions/仕様書/.keep")

      FileUtils.mkdir_p("features/support")
      system("touch features/support/.keep")

      FileUtils.mkdir_p("features/開発日記")
      FileUtils.touch("features/開発日記/.keep")
      FileUtils.mkdir_p("features/仕様書")
      FileUtils.touch("features/仕様書/.keep")

      if File.exist?("features/support/env.rb")
        puts "すでに features/support/env.rb が存在します。上書きはしません。"
      else
        File.write "features/support/env.rb", <<-EOF
require 'cucumber/rails'
require 'daddy/cucumber'
        EOF
      end      
    end
  end
end
