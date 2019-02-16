require 'daddy/itamae'
require_relative 'task_helper'

task :dad do
  `rake -aT`.split("\n").each do |line|
    if /rake dad(:.*)?/ =~ line
      puts line
    end
  end
end

rails_dependencies = %w[ environment ]
unless defined?(Rails)
  rails_dependencies.each do |t|
    task t.to_sym do; end
  end
end

namespace :dad do
  namespace :setup do

    Dir.glob('config/itamae/roles/*.rb').map{|path| File.basename(path, '.rb') }.each do |role|
      desc "ロール #{role} のセットアップを行います。"
      task role => :environment do
        role_file = "config/itamae/roles/#{role}.rb"
        log_level = ENV['DEBUG'] ? 'debug' : 'info'
        
        if ENV['DOCKER']
          tag = "#{Daddy.config.application}-#{role}"
          env = "USER=daddy ROLE=#{role}"
          if system("docker images | grep #{tag}")
            fail unless system("#{env} bundle exec itamae docker --ohai --image #{tag} --tag #{tag} --log-level=#{log_level} #{role_file}")
          else
            fail unless system("#{env} bundle exec itamae docker --ohai --image daddy-base --tag #{tag} --log-level=#{log_level} #{role_file}")
          end
        else
          fail unless system("ROLE=#{role} bundle exec itamae local --ohai --log-level=#{log_level} #{role_file}")
        end
      end
    end

  end

  task setup: :environment do
     Rake::Task['dad:setup:default'].invoke
  end
  
end
