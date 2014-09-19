require 'rake'

dependencies = ['environment', 'db:test:prepare']
unless defined?(Rails)
  dependencies.each do |t|
    task t do; end
  end
end

namespace :dad do

  task :cucumber => dependencies do |t, args|
    format = ENV['FORMAT'] || 'Daddy::Formatter::Html'

    options = [
      'DRIVER=' + (ENV['DRIVER'] || 'poltergeist'),
      'PAUSE=' + (ENV['PAUSE'] || '0'),
      'COVERAGE=' + (ENV['COVERAGE'] || 'true'),
      'ACCEPTANCE_TEST=true',
      'EXPAND=' + (ENV['EXPAND'] || 'true')
    ].join(' ')
    
    features = []
    ARGV[1..-1].each do |arg|
      unless arg.index('=')
        task arg.to_sym do ; end
        features << arg.gsub(/:/, '\:')
      end
    end

    output = "features/reports/index.html"
    output = "test/reports" if format == 'junit'

    run "bundle exec cucumber --guess --quiet --no-multiline -r features --format pretty --format #{format} --out #{output} #{features.join(' ')} #{options}"
  end
end
