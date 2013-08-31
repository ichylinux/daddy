# coding: UTF-8

require 'daddy/git'

namespace :dad do
  task :publish do
    fail('環境編集 TITLE を指定してください。') unless ENV['TITLE'] and not ENV['TITLE'].empty?

    if File.exist?("db/schema.rb")
      fail unless system("bundle exec rake db:schema:load RAILS_ENV=test")
    end

    system("mkdir -p features/reports")
    system("rm -Rf features/reports/*")

    fail unless system("bundle exec rake dad:cucumber PUBLISH=true features/開発日記")
    system("mkdir -p features/reports/diary")
    system("mv features/reports/index.html features/reports/diary")
    system("mv features/reports/images features/reports/diary")

    fail unless system("bundle exec rake dad:cucumber PUBLISH=true EXPAND=false features/仕様書")
    system("mkdir -p features/reports/spec")
    system("mv features/reports/index.html features/reports/spec")
    system("mv features/reports/images features/reports/spec")

    if ENV['BRANCH']
      current_branch = ENV['BRANCH']
    else
      git = Daddy::Git.new
      current_branch = git.current_branch
    end

    dir = '/var/lib/daddy/spec/' + title_to_dirname(ENV['TITLE']) 
    system("sudo mkdir -p #{dir}")
    system("sudo chown -R #{ENV['USER']}:#{ENV['USER']} #{dir}") 

    system("mkdir -p #{dir}/#{current_branch}")
    system("rm -Rf #{dir}/#{current_branch}/*")
    system("cp -Rf features/reports/* #{dir}/#{current_branch}/")
    system("cp -Rf coverage #{dir}/#{current_branch}/")
  end
  
end

def self.title_to_dirname(title)
  title.sub(' ', '_').downcase
end
