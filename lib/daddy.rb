# coding: UTF-8

module Daddy
  if defined?(Rails)
    require "daddy/railtie"
  else
    Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rake')].each do |f|
      load f
    end
  end
end

require 'sql_builder'