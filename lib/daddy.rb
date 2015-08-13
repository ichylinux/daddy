require 'daddy/utils/config'
require 'daddy/utils/string_utils'
require 'sql_builder'

module Daddy

  def self.config
    @_config ||= Daddy::Utils::Config.new(File.join('config', 'daddy.yml'))
  end

end

if defined?(Rails)
  require 'daddy/rails/engine'
  require 'daddy/rails/railtie'
else
  require 'closer/tasks'
  require 'daddy/tasks'
end
