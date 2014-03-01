# coding: UTF-8

class Daddy::Config
  
  def initialize(config_file)
    if @config.nil?
      
      if File.exist?(config_file)
        @config = YAML.load_file(config_file)
      end
    end
    @config
  end

  def use_feature_name?
    @config && @config['cucumber'] && !!@config['use_feature_name']
  end

end