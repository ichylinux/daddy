require 'rake'

namespace :dad do
  namespace :cucumber do
    task :install do
      FileUtils.mkdir_p("features")
      FileUtils.mkdir_p("features/step_definitions")
      FileUtils.touch("features/step_definitions/.keep")

      FileUtils.mkdir_p("features/support")
      system("touch features/support/.keep")
      File.write "features/support/env.rb", <<-EOF
require 'rails'
require 'daddy/cucumber'
      EOF
    end
  end
end
