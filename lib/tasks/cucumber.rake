# coding: UTF-8

require 'rake'

namespace :dad do

  task :cucumber => :environment do |t, args|
    driver = ENV['DRIVER'] || :webkit
    pause = ENV['PAUSE'] || 0
    coverage = ENV['COVERAGE'] || true
    expand = ENV['EXPAND']
    options = "DRIVER=#{driver} PAUSE=#{pause} COVERAGE=#{coverage} EXPAND=#{expand}"
    
    output_file = ENV['OUTPUT_FILE'] || 'index.html'

    features = []
    ARGV[1..-1].each do |arg|
      features << arg unless arg.index('=')
    end
    ret = system("bundle exec cucumber --guess -r features -f Daddy::Formatter::Html #{options} #{features.join(' ')} > features/reports/#{output_file}")
    fail unless ret    
  end
end
