if defined?(Rails)
  require 'daddy/rails/engine'
  require 'daddy/rails/railtie'
else
  Dir[File.join(File.dirname(__FILE__), 'tasks', '*.rake')].each do |f|
    load f
  end
end

require 'daddy/utils/config'
require 'daddy/utils/string_utils'
require 'prefecture'
require 'sql_builder'

module Daddy

  def self.config
    @_config ||= Daddy::Utils::Config.new(File.join('config', 'daddy.yml'))
  end

end
