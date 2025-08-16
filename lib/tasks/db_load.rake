require_relative 'task_helper'

namespace :dad do
  namespace :db do

    desc "データベースをロードします。"
    task :load do
      dump_file = ENV['DUMP_FILE'] || ask('ダンプファイル', :required => true)

      config = YAML.load(ERB.new(File.read('config/database.yml'), trim_mode: '-').result)[Rails.env]

      host = config['host'] || 'localhost'
      database = config['database']
      user = config['username']
      password = config['password']

      if dump_file.end_with?('.gz')
        run "zcat #{dump_file} | mysql -u #{user} -p#{password} -h #{host} #{database}",
          :mask => [/-p[^ ]+/, '-pFILTERED']
      else
        run "mysql -u #{user} -p#{password} -h #{host} #{database} < #{dump_file}",
          :mask => [/-p[^ ]+/, '-pFILTERED']
      end
    end

  end
end
