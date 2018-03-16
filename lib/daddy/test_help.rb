if ENV['COVERAGE']
  begin
    require 'simplecov'
  rescue LoadError => e
    raise 'simplecov not found.'
  end
  begin
    require 'simplecov-rcov'
  rescue LoadError => e
    raise 'simplecov-rcov not found.'
  end

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
  
    case ENV['FORMAT'].to_s.downcase
    when 'junit'
      MiniTest::Reporters.use! [
        MiniTest::Reporters::DefaultReporter.new,
        MiniTest::Reporters::JUnitReporter.new
      ]
    else
      MiniTest::Reporters.use! [
        MiniTest::Reporters::DefaultReporter.new(:color => true),
      ]
    end
  rescue LoadError => e
    raise 'minitest-reporters not found.'
  end
end
