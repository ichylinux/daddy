# coding: UTF-8

require 'daddy/git'

namespace :dad do
  task :publish do
    if File.exist?("#{Rails.root}/db/schema.rb")
      ret = system("bundle exec rake db:schema:load RAILS_ENV=test")
      fail unless ret
    end

    system("bundle exec rake dad:cucumber PUBLISH=true EXPAND=false OUTPUT_FILE=diary.html features/開発日記")
    system("bundle exec rake dad:cucumber PUBLISH=true EXPAND=false OUTPUT_FILE=index.html features/仕様書")

    if ENV['BRANCH']
      current_branch = ENV['BRANCH']
    else
      git = Daddy::Git.new
      current_branch = git.current_branch
    end

    dir = '/var/lib/daddy/spec'
    system("mkdir -p #{dir}/#{current_branch}")

    system("rm -Rf #{dir}/#{current_branch}/screenshots")
    system("cp -Rf features/reports/* #{dir}/#{current_branch}/")

    system("rm -Rf #{dir}/#{current_branch}/coverage")
    system("cp -Rf coverage #{dir}/#{current_branch}/")
  end
  
end
