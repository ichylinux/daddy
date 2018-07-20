require 'daddy/itamae'
require_relative 'task_helper'

task :dad do
  `rake -aT`.split("\n").each do |line|
    if /rake dad(:.*)?/ =~ line
      puts line
    end
  end
end

namespace :dad do
  
  %w[ app db ].each do |role|
    desc "ロール #{role} のセットアップを行います。"
    task role do
      role_file = "config/itamae/roles/#{role}.rb"
      fail unless system("bundle exec itamae local --ohai #{role_file}")
    end
  end

end
