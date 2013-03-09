# coding: UTF-8

require 'rake'

namespace :dad do
  task :cucumber => :environment do
    phase_no = File.basename(Rails.root).split('_')[1].to_i
    driver = ENV['DRIVER'] || :webkit
    pause = ENV['PAUSE'] || 0
    options = "PHASE_NO=#{phase_no} DRIVER=#{driver} PAUSE=#{pause}"

    system("mkdir -p features/reports")
    system("bundle exec rake db:schema:load RAILS_ENV=test")
    system("bundle exec cucumber --guess -r features -f Daddy::Formatter::Html #{options} > features/reports/index.html")    
  end
end
