require_relative 'task_helper'

namespace :dad do
  namespace :db do

    desc "データベースをダンプします。"
    task :dump do
      backup_dir = ask('出力先ディレクトリ', :required => true)

      config = YAML.load_file(File.join('config', 'database.yml'))[Rails.env]
      host = config['host'] || 'localhost'
      database = config['database']
      user = config['username']
      password = config['password']
      now = Time.now
      filepath = File.join(backup_dir, "#{database}-#{now.strftime('%Y-%m-%d_%H%M')}.dump.gz")

      run "mkdir -p #{File.dirname(filepath)}",
          "mysqldump -u #{user} -p#{password} -h #{host} #{database} | gzip > #{filepath}",
          :gsub => [/-p[^ ]+/, '-pFILTERED']
    end
  end

end
