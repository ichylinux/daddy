# coding: UTF-8

require 'rake'

unless defined?(Rails)
  task :environment do; end
end

namespace :dad do

  task :cucumber => ['environment', 'db:test:prepare'] do |t, args|
    format = ENV['FORMAT'] || 'Daddy::Formatter::Html'

    options = [
      "DRIVER=" + (ENV['DRIVER'] || 'selenium'),
      "PAUSE=" + (ENV['PAUSE'] || '0'),
      "COVERAGE=" + (ENV['COVERAGE'] || 'true'),
      "EXPAND=" + (ENV['EXPAND'] || 'true')
    ].join(' ')
    
    features = []
    ARGV[1..-1].each do |arg|
      unless arg.index('=')
        task arg.to_sym do ; end
        features << arg.gsub(/:/, '\:')
      end
    end

    output = "features/reports/index.html"
    output = "features/reports" if format == 'junit'

    command = "bundle exec cucumber --guess --quiet --no-multiline -r features --format pretty --format #{format} --out #{output} #{features.join(' ')} #{options}"
    #puts command
    ret = system(command)
    fail unless ret
  end
end
