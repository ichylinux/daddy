# coding: UTF-8

require 'daddy/git'

namespace :dad do
  task :publish do
    if File.exist?("#{Rails.root}/db/schema.rb")
      ret = system("bundle exec rake db:schema:load RAILS_ENV=test")
      fail unless ret
    end

    system("mkdir -p features/reports")
    system("rm -Rf features/reports/*")
    system("bundle exec rake dad:cucumber PUBLISH=true EXPAND=false features/開発日記")
    system("mkdir -p features/reports/diary")
    system("mv features/reports/index.html features/reports/diary")
    system("mv features/reports/screenshots features/reports/diary")
    system("bundle exec rake dad:cucumber PUBLISH=true EXPAND=false features/仕様書")

    if ENV['BRANCH']
      current_branch = ENV['BRANCH']
    else
      git = Daddy::Git.new
      current_branch = git.current_branch
    end

    dir = '/var/lib/daddy/spec'
    system("sudo mkdir -p #{dir}")
    system("sudo chown -R #{ENV['USER']}:#{ENV['USER']} #{dir}") 

    system("mkdir -p #{dir}/#{current_branch}")
    system("rm -Rf #{dir}/#{current_branch}/*")
    system("cp -Rf features/reports/* #{dir}/#{current_branch}/")
    system("cp -Rf coverage #{dir}/#{current_branch}/")
  end
  
end
