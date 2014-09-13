require 'rake'
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

def self.template_dir
  File.join(File.dirname(File.dirname(File.dirname(__FILE__))), 'templates')
end

def self.render(template, options = {})
  File.write(options[:to], ERB.new(File.read(template), 0, '-').result)
end