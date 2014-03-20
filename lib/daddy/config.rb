# coding: UTF-8

class Daddy::Config
  
  def initialize(config_file)
    if @config.nil?
      if File.exist?(config_file)
        @config = YAML.load_file(config_file)
      else
        @config = {}
      end
    end
  end

  def use_feature_name?
    @config['cucumber'] && !!@config['cucumber']['use_feature_name']
  end

  def fluentd_nginx?
    @config['fluentd'] && !!@config['fluentd']['nginx']
  end
end