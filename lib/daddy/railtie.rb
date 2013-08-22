# coding: UTF-8

require 'rails'
require 'rails_i18n'

if ENV["COVERAGE"]
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

  if ENV['COMMAND_NAME']
    SimpleCov.command_name(ENV['COMMAND_NAME'])
  end

  SimpleCov.merge_timeout(7200)
  SimpleCov.start 'rails'
end

require 'daddy/model'
require 'daddy/helpers/html_helper'

module Daddy
  class Railtie < Rails::Railtie
    initializer 'active_record_extension' do
      ActiveSupport.on_load :active_record do
        require 'daddy/models/crud_extension'
        require 'daddy/models/query_extension'
        ActiveRecord::Base.send(:include, Daddy::Models::CrudExtension)
        ActiveRecord::Base.send(:include, Daddy::Models::QueryExtension)
      end
    end

    initializer 'quiet_assets' do
      load File.join(File.dirname(__FILE__), 'rails', 'quiet_assets.rb')
    end

    rake_tasks do
      lib = File.dirname(File.dirname(__FILE__))
      Dir[File.join(lib, 'tasks/*.rake')].each do |f|
        load f
      end
    end
  end
end
