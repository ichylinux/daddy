require 'yaml'
require 'daddy/utils/config'

module Daddy

  def self.config
    @_config ||= Daddy::Utils::Config.new(YAML.load_file('config/daddy.yml'))
  end

end
