# coding: UTF-8

require 'rake'

task :dad do
  `rake -aT`.force_encoding('UTF-8').split("\n").each do |line|
    if /rake dad(:.*)?/ =~ line
      puts line
    end
  end
end

namespace :dad do
  task :install do
    system('rake dad:cucumber:install')
  end
end
