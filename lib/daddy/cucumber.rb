require 'capybara/cucumber'
require_relative 'cucumber/helpers'

Capybara.default_selector = :css

Before do
  resize_window(1280, 720)
end
