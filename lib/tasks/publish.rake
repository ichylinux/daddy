# coding: UTF-8

require 'daddy/git'
require 'nokogiri'

namespace :dad do
  task :publish do
    fail('環境編集 TITLE を指定してください。') unless ENV['TITLE'] and not ENV['TITLE'].empty?

    if File.exist?("db/schema.rb")
      ENV['RAILS_ENV'] = 'test'
      Rake::Task['db:schema:load'].invoke
    end

    system("mkdir -p features/reports")
    system("rm -Rf features/reports/*")

    fail unless system("bundle exec rake dad:cucumber PUBLISH=true EXPAND=false COVERAGE=false features/開発日記")
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

    # 公開
    base_dir = dad_publish_base_dir(ENV['TITLE']) 
    system("sudo mkdir -p #{base_dir}")
    system("sudo chown -R #{ENV['USER']}:#{ENV['USER']} #{base_dir}") 
    system("mkdir -p #{base_dir}/#{branch}")
    system("rm -Rf #{base_dir}/#{branch}/*")
    system("cp -Rf features/reports/* #{base_dir}/#{branch}/")
    if File.exist? 'coverage'
      system("cp -Rf coverage #{base_dir}/#{branch}/")
    end

    # 開発日記を統合
    if branch == 'master'
      features = []
      Dir[base_dir + '/*'].each do |dir|
        next unless File.directory?(dir)

        html = dir + '/diary/index.html'
        doc = Nokogiri::HTML(File.read(html))
        doc.css('div.feature').each do |div|
          features << div
        end
      end
      system("bundle exec rake dad:cucumber PUBLISH=true COVERAGE=false features/support") # 空HTMLを生成
      doc = Nokogiri::HTML(File.read('features/reports/index.html'))
      contents_div = doc.css('div.contents').first
      features.each do |div|
        contents_div.add_child(div)
      end
      File.write("#{base_dir}/index.html", doc)
    end
  end
  
end

def self.dad_publish_base_dir(title)
  '/var/lib/daddy/' + dad_publish_title_to_dirname(title) 
end

def self.dad_publish_title_to_dirname(title)
  title.sub(' ', '_').downcase
end
