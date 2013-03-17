# coding: UTF-8

require 'rails'
require 'rails_i18n'

module Daddy
  class Railtie < Rails::Railtie
    rake_tasks do
      lib = File.dirname(File.dirname(__FILE__))
      Dir[File.join(lib, 'tasks/*.rake')].each do |f|
        load f
      end
    end
  end
end
