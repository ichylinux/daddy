# coding: UTF-8

require 'rake'

namespace :dad do
  namespace :cucumber do
    task :install do
      system("mkdir -p features/reports")
      system("mkdir -p features/step_definitions")
      system("mkdir -p features/support")

      if File.exist?("features/support/env.rb")
        puts "すでに features/support/env.rb が存在します。上書きはしません。"
      else
        system("echo '# coding: UTF-8'            >  features/support/env.rb")
        system("echo                              >> features/support/env.rb")
        system("echo \"require 'daddy/cucumber'\" >> features/support/env.rb")
      end
    end
  end
end
