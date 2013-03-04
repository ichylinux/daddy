# coding: UTF-8

module Daddy
  require "daddy/railtie" if defined?(Rails)
  require "daddy/cucumber" if defined?(Cucumber)
end
