# coding: UTF-8

require 'daddy/git'
require 'nokogiri'

namespace :dad do
  task :publish do
    fail('環境編集 TITLE を指定してください。') unless ENV['TITLE'] and not ENV['TITLE'].empty?

    # dir = '/var/lib/daddy/spec/' + title_to_dirname(ENV['TITLE']) 
    # Dir[dir + '/*'].each do |dir|
      # features = []
      # html = dir + '/diary/index.html'
      # doc = Nokogiri::HTML(File.read(html))
      # doc.css('div.feature').each do |div|
        # features << div.to_s
      # end
      # puts features.join
    # end
    # exit

    if File.exist?("db/schema.rb")
      ENV['RAILS_ENV'] = 'test'
      Rake::Task['db:schema:load'].invoke
    end

    system("mkdir -p features/reports")
    system("rm -Rf features/reports/*")

    fail unless system("bundle exec rake dad:cucumber PUBLISH=true COVERAGE=false features/開発日記")
    system("mkdir -p features/reports/diary")
    system("mv features/reports/index.html features/reports/diary")
    system("mv features/reports/images features/reports/diary")

    fail unless system("bundle exec rake dad:cucumber PUBLISH=true EXPAND=false features/仕様書")
    system("mkdir -p features/reports/spec")
    system("mv features/reports/index.html features/reports/spec")
    system("mv features/reports/images features/reports/spec")

    if ENV['BRANCH']
      branch = ENV['BRANCH']
    else
      git = Daddy::Git.new
      branch = git.current_branch
    end

    dir = '/var/lib/daddy/spec/' + title_to_dirname(ENV['TITLE']) 
    system("sudo mkdir -p #{dir}")
    system("sudo chown -R #{ENV['USER']}:#{ENV['USER']} #{dir}") 

    system("mkdir -p #{dir}/#{branch}")
    system("rm -Rf #{dir}/#{branch}/*")
    system("cp -Rf features/reports/* #{dir}/#{branch}/")
    if File.exist? 'coverage'
      system("cp -Rf coverage #{dir}/#{branch}/")
    end

  end
  
end

def self.title_to_dirname(title)
  title.sub(' ', '_').downcase
end
