# coding: UTF-8

if defined?(Rails)
  require 'daddy/rails/engine'
  require 'daddy/rails/railtie'
else
  Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rake')].each do |f|
    load f
  end
end

require 'sql_builder'
require 'tax'

module Daddy
end
