# coding: UTF-8

require 'rake'

namespace :dad do
  task :cucumber => :environment do
    phase_no = `git branch`.gsub(/[a-zA-Z]*/, '').to_i
    driver = ENV['DRIVER'] || :webkit
    pause = ENV['PAUSE'] || 0
    options = "PHASE_NO=#{phase_no} DRIVER=#{driver} PAUSE=#{pause}"

    system("bundle exec cucumber --guess -r features -f Daddy::Formatter::Html #{options} > features/reports/index.html")    
  end
end
