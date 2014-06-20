require 'erb'
require 'yaml'

def self.rails_root
  ENV['RAILS_ROOT'] || Rails.root
end

def self.rails_env
  ENV['RAILS_ENV'] || 'development'
end

def self.app_name
  YAML.load_file("#{rails_root}/config/database.yml")[Rails.env]['database']
end
