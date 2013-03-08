# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :cucumber do
    task :install do
      system("mkdir -p features")
      
      system("mkdir -p features/step_definitions")
      system("touch features/step_definitions/.gitkeep")
      system("mkdir -p features/step_definitions/開発日記")
      system("touch features/step_definitions/開発日記/.gitkeep")

      system("mkdir -p features/support")
      system("touch features/support/.gitkeep")

      system("mkdir -p features/開発日記")
      system("touch features/開発日記/.gitkeep")

      if File.exist?("features/support/env.rb")
        puts "すでに features/support/env.rb が存在します。上書きはしません。"
      else
        system("echo '# coding: UTF-8'            >  features/support/env.rb")
        system("echo \"require 'daddy/cucumber'\" >> features/support/env.rb")
      end      
    end
  end
end
