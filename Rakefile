# coding: UTF-8

load 'lib/daddy/git/git_utils.rb'

task :test do |t|
  system("cd careerlife && rake test")
end

task :default => :test

namespace :dad do
  namespace :publish do
    task :all do
      Daddy::Git::GitUtils.get_branches.each do |b|
        puts "ブランチ #{b} を公開します。"

        ret = system("git checkout #{b}")
        fail unless ret
        ret = system("cd careerlife && bundle exec rake dad:publish BRANCH=#{b}")
        fail unless ret
      end
    end
  end
end
