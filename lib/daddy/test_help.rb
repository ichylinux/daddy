if ENV["COVERAGE"]
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

  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start 'rails' 
end

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
