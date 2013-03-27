require 'daddy/capistrano/remote_cache_subdir'

set :default_run_options, :pty => true

set :application, "careerlife"
set :repository,  "git://github.com/ichylinux/daddy.git"
set :scm, :git
set :branch, 'master'

set :user, ENV['USER']
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_subdir, application
set :strategy, Daddy::Capistrano::RemoteCacheSubdir.new(self)

set :asset_env, "#{asset_env} RAILS_RELATIVE_URL_ROOT=/careerlife"

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
set :rails_env, :production
set :rails_path, '/careerlife'
set :unicorn_binary, "/usr/local/bin/unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && RAILS_RELATIVE_URL_ROOT=#{rails_path} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} --path #{rails_path} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

after "deploy:setup" do
  run "#{try_sudo} chown -R #{user}:#{user} #{deploy_to}"
end

