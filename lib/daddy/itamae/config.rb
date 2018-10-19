require 'yaml'
require 'daddy/utils/config'

module Daddy

  def self.config
    if @_config.nil?
      daddy_yml = File.join('config', 'daddy.yml')
      puts daddy_yml
      if File.exist?(daddy_yml)
        @_config = Daddy::Utils::Config.new(daddy_yml)
      else
        @_config = Daddy::Utils::Config.new
      end
    end

    @_config
  end

end
