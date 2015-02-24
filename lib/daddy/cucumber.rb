require 'daddy'

if defined?(Rails)
  require 'capybara/rails'
  ActionController::Base.allow_rescue = false
end

require 'daddy/git'
require 'differ'
require_relative 'differ/html_patch.rb'

Differ.format = :html

require 'capybara/cucumber'
require 'capybara/webkit' if ENV['DRIVER'] == 'webkit'
require 'capybara/poltergeist' if ENV['DRIVER'] == 'poltergeist'

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
      if x.start_with?('features/開発日記') and y.start_with?('features/開発日記')
        x <=> y
      elsif x.start_with?('features/仕様書') and y.start_with?('features/仕様書')
        x <=> y
      elsif x.start_with?('features/開発日記')
        -1
      elsif y.start_with?('features/開発日記')
        1
      else
        x <=> y
      end
    end
    
    sorted_files
  }
end

require_relative 'cucumber/helpers'
require_relative 'cucumber/hooks/database' if defined?(Rails)

Before do
  resize_window(1280, 720)
end
