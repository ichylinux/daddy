if ENV['COVERAGE']
  begin
    require 'simplecov'
  rescue LoadError => e
    raise 'simplecov not found.'
  end
  begin
    require 'simplecov-rcov'
    require 'daddy/coverage/rcov_formatter'
  rescue LoadError => e
    raise 'simplecov-rcov not found.'
  end

  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    Daddy::Coverage::RcovFormatter
  ])

  SimpleCov.start do
    add_filter '/features/'
    add_filter '/test/'
    add_filter '/user_stories/'
    add_filter '/vendor/'
  end
end

if ENV['FORMAT']
  begin
    require 'minitest/reporters'

    if Gem::Version.new(Minitest::VERSION) >= Gem::Version.new('5.16.0')
      case ENV['FORMAT'].to_s.downcase
      when 'junit'
        Minitest::Reporters.use! [
          Minitest::Reporters::DefaultReporter.new,
          Minitest::Reporters::JUnitReporter.new
        ]
      else
        Minitest::Reporters.use! [
          Minitest::Reporters::DefaultReporter.new(color: true),
        ]
      end
    else
      case ENV['FORMAT'].to_s.downcase
      when 'junit'
        MiniTest::Reporters.use! [
          MiniTest::Reporters::DefaultReporter.new,
          MiniTest::Reporters::JUnitReporter.new
        ]
      else
        MiniTest::Reporters.use! [
          MiniTest::Reporters::DefaultReporter.new(color: true),
        ]
      end
    end
  rescue LoadError => e
    raise 'minitest-reporters not found.'
  end
end
