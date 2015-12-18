require 'capybara/cucumber'

case ENV['DRIVER']
when 'poltergeist'
  require 'capybara/poltergeist' 
when 'webkit'
  require 'capybara/webkit'
end

Capybara.default_driver = (ENV['DRIVER'] || :selenium).to_sym
Capybara.default_selector = :css

def override_method(obj, method_name, &block)
  klass = class <<obj; self; end
  klass.send(:undef_method, method_name)
  klass.send(:define_method, method_name, block)
end
  
AfterConfiguration do |configuration|
  feature_files =  configuration.feature_files
 
  override_method(configuration, :feature_files) {
    sorted_files = feature_files.sort do |x, y|
      x <=> y
    end
  }
end

require_relative 'cucumber/helpers'
require_relative 'cucumber/hooks/database' if defined?(Rails)

Before do
  resize_window(1280, 720)
end
