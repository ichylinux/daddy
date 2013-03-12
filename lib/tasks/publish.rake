# coding: UTF-8

namespace :dad do
  task :publish do |t|
    system("rake test PUBLISH=true")

    system("mkdir -p tmp")
    system("git branch > tmp/branches")
    current_branch = 'master'
    File.readlines('tmp/branches').each do |b|
      if b.start_with?('*')
        current_branch = b.split[1]
        break
      end
    end
  
    unless File.exist?('tmp/gh-pages')
      system("cd tmp && git clone -b gh-pages git@github.com:ichylinux/daddy.git gh-pages")
    end 
    system("mkdir -p tmp/gh-pages/#{current_branch}")
    system("cd tmp/gh-pages && git rm screenshots/*")
    system("cp -Rf features/reports/* tmp/gh-pages/#{current_branch}/")
    system("cd tmp/gh-pages && git add .")
    system("cd tmp/gh-pages && git commit -m 'publish'")
    system("cd tmp/gh-pages && git push")
  end
end
