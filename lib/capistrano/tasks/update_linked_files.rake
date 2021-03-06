namespace :deploy do

  desc 'Upload linked_files from local server'
  task :update_linked_files do
    fetch(:linked_files, []).each do |file|
      local_file = File.join(fetch(:deploy_to), file)

      unless File.exist?(local_file)
        error "File does not exist on local server: #{local_file}"
        exit 1
      end

      on roles(:all) do
        upload! local_file, File.join(shared_path, file)
      end
    end
  end

end

after 'deploy:check:make_linked_dirs', 'deploy:update_linked_files'
