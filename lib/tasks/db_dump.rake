require_relative 'task_helper'

namespace :dad do
  namespace :db do
    desc 'データベースをダンプします。'
    task :dump do
      ENV['DUMP_DIR'] ||= ask('出力先ディレクトリ', :required => true)
      run_rustic 'db', 'dump'
    end
  end
end