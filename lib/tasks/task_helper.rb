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

def self.task_file(*path)
  File.join(File.dirname(__FILE__), *path)
end

def self.render(template, options = {})
  FileUtils.mkdir_p(File.dirname(options[:to]))
  File.write(options[:to], ERB.new(File.read(template), 0, '-').result)
end

def self.ask(prompt, options = {})
  if options[:default]
    print prompt + " [#{options[:default]}]: "
  else
    print prompt + ": "
  end

  if options[:password]
    system("stty -echo")
    at_exit do
      system("stty echo")
    end
  end

  answer = STDIN.gets.strip
  answer = options[:default] if answer.blank?

  if options[:password]
    system("stty echo")
    puts
  end

  if options[:required] and answer.blank?
    raise "必須です。処理を中止します。"
  end

  answer.blank? ? nil : answer
end

def self.run(*commands)
  commands.each do |c|
    puts c
    fail unless system(c)
  end
end