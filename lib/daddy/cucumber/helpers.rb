require 'closer/helpers'

if defined?(Rails)
  env_caller = File.dirname(caller.detect{ |f| f =~ /\/env\.rb:/ }) if caller.detect{ |f| f =~ /\/env\.rb:/ }
  ENV['RAILS_ENV'] ||= 'test'
  ENV['RAILS_ROOT'] ||= File.expand_path(env_caller + '/../..')
  require File.expand_path(ENV['RAILS_ROOT'] + '/config/environment')
  require 'rails/test_help'
  MultiTest.disable_autorun

  require 'capybara/rails'
end

Dir::glob(File.dirname(__FILE__) + '/helpers/*.rb').each do |file|
  require file
end

Dir::glob(File.dirname(__FILE__) + '/step_definitions/*.rb').each do |file|
  load file
end
