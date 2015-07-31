require 'rake'

namespace :dad do
  namespace :db do
    
    desc 'database.yml を生成します。'
    task :config do
      @app_name = File.basename(Rails.root)[0..15]

      template File.join(File.dirname(__FILE__), 'db/database.yml.erb')
      render template, :to => 'config/database.yml'
    end
  end
end
