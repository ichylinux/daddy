# coding: UTF-8

require 'cucumber/rails'
require 'capybara/poltergeist'
require 'capybara/webkit'
require 'daddy/git'
require 'differ'

Differ.format = :html

Capybara.default_driver = (ENV['DRIVER'] || :selenium).to_sym
Capybara.default_selector = :css

ActionController::Base.allow_rescue = false

Dir::glob(File.dirname(__FILE__) + '/cucumber/*.rb').each do |file|
  require file
end

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

Before do
  ActiveRecord::Fixtures.reset_cache
  fixtures_folder = File.join(Rails.root, 'test', 'fixtures')
  fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
  ActiveRecord::Fixtures.create_fixtures(fixtures_folder, fixtures)
end
