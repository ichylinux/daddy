require 'daddy/utils/config'

module Daddy

  def self.config
    @_config ||= Daddy::Utils::Config.new(File.join('config', 'daddy.yml'))
  end

end
