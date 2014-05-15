# coding: UTF-8

if defined?(Rails)
  require 'daddy/rails/engine'
  require 'daddy/rails/railtie'
else
  Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rake')].each do |f|
    load f
  end
end

require 'daddy/utils/string_utils'
require 'prefecture'
require 'sql_builder'
require 'tax'

module Daddy
  require 'daddy/config'

  def self.config
    @_config ||= Daddy::Config.new(config_file = File.join('config', 'daddy.yml'))
  end

end
