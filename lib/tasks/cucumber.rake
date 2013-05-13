# coding: UTF-8

require 'rake'

namespace :dad do

  task :cucumber => :environment do |t, args|
    format = ENV['FORMAT'] || 'Daddy::Formatter::Html'

    options = [
      "DRIVER=" + (ENV['DRIVER'] || 'webkit'),
      "PAUSE=" + (ENV['PAUSE'] || '0'),
      "COVERAGE=" + (ENV['COVERAGE'] || 'true'),
      "EXPAND=" + (ENV['EXPAND'] || 'true')
    ].join(' ')
    
    features = []
    ARGV[1..-1].each do |arg|
      features << arg unless arg.index('=')
    end

    output = "> features/reports/index.html"
    output = "-o features/reports" if format == 'junit'

    command = "bundle exec cucumber --guess -r features -f #{format} #{features.join(' ')} #{options} #{output}"
    #puts command
    ret = system(command)
    fail unless ret
  end
end
