# coding: UTF-8

require 'cucumber/rails'
require "capybara/webkit"
require 'daddy/cucumber/assert'
require 'daddy/cucumber/capture'

Capybara.default_driver = (ENV['DRIVER'] || :selenium).to_sym
Capybara.default_selector = :css

ActionController::Base.allow_rescue = false

World(Daddy::Cucumber::Assert)
World(Daddy::Cucumber::Capture)

