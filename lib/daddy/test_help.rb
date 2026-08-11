if ENV['COVERAGE']
  begin
    require 'simplecov'
  rescue LoadError => e
    raise 'simplecov not found.'
  end

  SimpleCov.start do
    skip '/features/'
    skip '/test/'
    skip '/user_stories/'
    skip '/vendor/'
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
