if ENV["COVERAGE"]
  require 'simplecov'
  require 'simplecov-rcov'
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
