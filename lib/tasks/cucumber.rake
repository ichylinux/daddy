# coding: UTF-8

require 'rake'

namespace :dad do
  task :cucumber => :environment do
    phase_no = File.basename(Rails.root).split('_')[1].to_i
    Rake::Task['db:test:prepare'].execute    
    system("bundle exec cucumber -r features -f Daddy::Formatter::Html PHASE_NO=#{phase_no} DRIVER=webkit EXPAND=true > features/reports/index.html")    
  end
end
