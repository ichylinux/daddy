require 'daddy/capistrano/remote_cache_subdir'

set :default_run_options, :pty => true
set :use_sudo, false

set :application, "careerlife"
set :repository,  "git://github.com/ichylinux/daddy.git"
set :scm, :git
set :branch, 'master'

set :user, ENV['USER']
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_subdir, application
set :strategy, Daddy::Capistrano::RemoteCacheSubdir.new(self)

#set :asset_env, "#{asset_env} RAILS_RELATIVE_URL_ROOT=/careerlife"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "sudo service unicorn_careerlife_pro start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "sudo service unicorn_careerlife_pro stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "sudo service unicorn_careerlife_pro restart"
  end
end

