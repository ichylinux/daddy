require 'capybara/cucumber'

case ENV['DRIVER']
when 'poltergeist'
  require 'capybara/poltergeist'
end

Capybara.default_driver = (ENV['DRIVER'] || :selenium).to_sym
Capybara.default_selector = :css

require_relative 'cucumber/helpers'

Before do
  resize_window(1280, 720)
end
