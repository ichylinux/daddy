# coding: UTF-8

require 'daddy/cucumber'


Capybara.default_driver = (ENV['DRIVER'] || :selenium).to_sym
Capybara.default_selector = :css

ActionController::Base.allow_rescue = false
