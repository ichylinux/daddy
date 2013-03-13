# coding: UTF-8

require 'rake'

namespace :dad do
  task :cucumber => :environment do |t, args|
    phase_no = `git branch`.gsub(/[a-zA-Z]*/, '').to_i
    driver = ENV['DRIVER'] || :webkit
    pause = ENV['PAUSE'] || 0
    options = "PHASE_NO=#{phase_no} DRIVER=#{driver} PAUSE=#{pause}"
    
    output_file = ENV['OUTPUT_FILE'] || 'index.html'

    features = []
    ARGV[1..-1].each do |arg|
      features << arg unless arg.index('=')
    end
    system("bundle exec cucumber --guess -r features -f Daddy::Formatter::Html #{options} #{features.join(' ')} > features/reports/#{output_file}")    
  end
end
