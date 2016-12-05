require 'daddy/itamae'

template 'config/unicorn.rb' do
  variables :timeout => 300
end

case os_version
when /rhel-6\.(.*?)/
  template "/etc/init.d/#{ENV['APP_NAME']}" do
    source File.join(File.dirname(__FILE__), 'templates/init.d/app.erb')
    user 'root'
    owner 'root'
    group 'root'
    mode '755'
    variables :app_name => ENV['APP_NAME'],
        :rails_env => ENV['RAILS_ENV'],
        :rails_root => ENV['RAILS_ROOT'],
        :worker_processes => ENV['RAILS_ENV'] == 'production' ? 2 : 1
  end
when /rhel-7\.(.*?)/
  template "/etc/systemd/system/#{ENV['APP_NAME']}.service" do
    source File.join(File.dirname(__FILE__), 'templates/systemd/app.service.erb')
    user 'root'
    owner 'root'
    group 'root'
    mode '644'
    variables :app_name => ENV['APP_NAME'],
        :rails_env => ENV['RAILS_ENV'],
        :rails_root => ENV['RAILS_ROOT'],
        :user => ENV['USER'],
        :worker_processes => ENV['RAILS_ENV'] == 'production' ? 2 : 1
  end

  execute 'systemctl daemon-reload' do
    user 'root'
    subscribes :run, "template[/etc/systemd/system/#{ENV['APP_NAME']}.service]"
    action :nothing
  end
end

service "#{ENV['APP_NAME']}" do
  user 'root'
  action :enable
end
