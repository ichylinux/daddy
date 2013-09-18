# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :cucumber do
    task :install do
      FileUtils.mkdir_p("features")
      
      FileUtils.mkdir_p("features/step_definitions")
      FileUtils.touch("features/step_definitions/.gitkeep")
      FileUtils.mkdir_p("features/step_definitions/開発日記")
      FileUtils.touch("features/step_definitions/開発日記/.gitkeep")
      FileUtils.mkdir_p("features/step_definitions/仕様書")
      FileUtils.touch("features/step_definitions/仕様書/.gitkeep")

      FileUtils.mkdir_p("features/support")
      system("touch features/support/.gitkeep")

      FileUtils.mkdir_p("features/開発日記")
      FileUtils.touch("features/開発日記/.gitkeep")
      FileUtils.mkdir_p("features/仕様書")
      FileUtils.touch("features/仕様書/.gitkeep")

      if File.exist?("features/support/env.rb")
        puts "すでに features/support/env.rb が存在します。上書きはしません。"
      else
        File.write "features/support/env.rb", <<-EOF
# coding: UTF-8

require 'cucumber/rails'
require 'daddy/cucumber'
        EOF
      end      
    end
  end
end
