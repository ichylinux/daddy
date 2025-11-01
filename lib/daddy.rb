require 'daddy/utils/config'
require 'sql_builder'

module Daddy

  def self.config
    if @_config.nil?
      daddy_yml = File.join('config', 'daddy.yml')
      if File.exist?(daddy_yml)
        @_config = Daddy::Utils::Config.new(daddy_yml)
      else
        @_config = Daddy::Utils::Config.new
      end
    end

    @_config
  end

end

if defined?(Rails)
  require 'daddy/rails/engine'
  require 'daddy/rails/railtie'
end
