# coding: UTF-8

require 'rails'

module Daddy
  class Railtie < Rails::Railtie
    rake_tasks do
      require 'tasks/create_databases.rake'
    end
  end
end
