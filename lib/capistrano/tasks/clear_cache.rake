namespace :deploy do

  desc 'Clear temporary cache'
  task :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'tmp:cache:clear'
      end
    end
  end
end

after 'deploy:restart', 'deploy:clear_cache'
