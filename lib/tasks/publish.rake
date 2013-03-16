# coding: UTF-8

namespace :dad do
  task :publish do
    system("mkdir -p features/reports")
    system("bundle exec rake db:test:prepare")
    system("bundle exec rake dad:cucumber PUBLISH=true OUTPUT_FILE=diary.html features/開発日記")
    system("bundle exec rake dad:cucumber PUBLISH=true OUTPUT_FILE=index.html features/仕様書")

    system("mkdir -p tmp")

    if ENV['BRANCH']
      current_branch = ENV['BRANCH']
    else
      system("git branch > tmp/branches")
      current_branch = 'master'
      File.readlines('tmp/branches').each do |b|
        if b.start_with?('*')
          current_branch = b.split[1]
          break
        end
      end
    end
  
    unless File.exist?('tmp/gh-pages')
      system("cd tmp && git clone -b gh-pages git@github.com:ichylinux/daddy.git gh-pages")
    else
      system("cd tmp/gh-pages && git pull")
    end
    system("mkdir -p tmp/gh-pages/#{current_branch}")

    system("cd tmp/gh-pages && git rm -r #{current_branch}/screenshots")
    system("cp -Rf features/reports/* tmp/gh-pages/#{current_branch}/")

    system("cd tmp/gh-pages && git rm -r #{current_branch}/coverage")
    system("cp -Rf coverage tmp/gh-pages/#{current_branch}/")

    system("cd tmp/gh-pages && git add .")
    system("cd tmp/gh-pages && git commit -m 'publish'")
    system("cd tmp/gh-pages && git push")
  end
  
end
