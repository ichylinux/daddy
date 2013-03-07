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

Dir::glob(File.dirname(__FILE__) + '/cucumber/step_definitions/*.rb').each do |file|
  load file
end

def override_method(obj, method_name, &block)
  klass = class <<obj; self; end
  klass.send(:undef_method, method_name)
  klass.send(:define_method, method_name, block)
end
  
AfterConfiguration do |configuration|
  feature_files =  configuration.feature_files
 
  override_method(configuration, :feature_files) {
    sorted_files = feature_files.sort do |x, y|
      if x.start_with?('features/開発日記') and y.start_with?('features/開発日記')
        x <=> y
      elsif y.start_with?('features/開発日記')
        1
      else
        -1
      end
    end
    
    sorted_files
  }
end
