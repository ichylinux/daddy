require 'minitest'
MultiTest.disable_autorun

require 'closer'

begin
  require 'cucumber/rails'
  puts 'cucumber-rails loaded.'
rescue LoadError => e
end

DatabaseCleaner.strategy = :truncation

require_relative 'hooks/fixtures'

require 'daddy/cucumber'
