require 'yaml'
require 'daddy/utils/config'

module Daddy

  def self.config
    if @_config.nil?
      daddy_yml = File.join('config', 'daddy.yml')
      if File.exist?(daddy_yml)
        parsed = ERB.new(File.read(daddy_yml), 0, '-').result
        @_config = Daddy::Utils::Config.new(YAML.load(parsed))
      else
        @_config = Daddy::Utils::Config.new
      end
    end

    @_config
  end

end
