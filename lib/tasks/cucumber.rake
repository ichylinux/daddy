# coding: UTF-8

require 'rake'

namespace :dad do
  task :cucumber => :environment do
    phase_no = File.basename(Rails.root).split('_')[1].to_i
    driver = ENV['DRIVER'] || :webkit
    pause = ENV['PAUSE'] || 0

    system("mkdir -p features/reports")
    system("bundle exec rake db:schema:load RAILS_ENV=test")
    system("bundle exec cucumber -r features -f Daddy::Formatter::Html PHASE_NO=#{phase_no} DRIVER=#{driver} PAUSE=#{pause} > features/reports/index.html")    
  end
end
