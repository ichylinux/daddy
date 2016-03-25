require 'closer'
require 'rails'

begin
  require 'cucumber/rails'
rescue LoadError => e
  puts 'cucumber-rails not found.'
end

DatabaseCleaner.strategy = :truncation

require_relative 'hooks/fixtures'

require 'daddy/cucumber'
