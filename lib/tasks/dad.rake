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
  Dir.glob('config/itamae/roles/*.rb').map{|path| File.basename(path, '.rb') }.each do |role|

    namespace role do
      desc "ロール #{role} のセットアップを行います。"
      task :setup do
        role_file = "config/itamae/roles/#{role}.rb"
        fail unless system("bundle exec itamae local --ohai #{role_file}")
      end
    end

  end
end
