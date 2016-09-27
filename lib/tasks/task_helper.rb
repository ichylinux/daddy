require 'rake'
require 'erb'
require 'yaml'
require File.expand_path('../../daddy/version', __FILE__)

require 'i18n'
I18n.load_path += Dir.glob(File.expand_path('../../tasks/locale/*.yml', __FILE__))
I18n.locale = ENV['LANG'][0..1] if ENV['LANG']

def self.daddy_version
  Daddy::VERSION
end

def self.rails_root
  ENV['RAILS_ROOT'] || @_rails_root ||= ask('RAILS_ROOT', :default => Rails.root)
end

def self.rails_env(options = {})
  ENV['RAILS_ENV'] || @_rails_env ||= ask('RAILS_ENV', :default => options.fetch(:default, 'development'))
end

def self.app_name
  YAML.load_file("#{rails_root}/config/database.yml")[rails_env]['database']
end

def self.template_dir
  File.join(File.dirname(File.dirname(File.dirname(__FILE__))), 'templates')
end

def self.cookbook_dir
  File.expand_path('../../../itamae/cookbooks', __FILE__)
end

def self.dry_run?
  %w{ DRY_RUN DR }.each do |key|
    return true if %w{ true t yes y 1 }.include?(ENV[key].to_s.downcase)
  end
  
  false
end

def self.task_file(*path)
  File.join(File.dirname(__FILE__), *path)
end

def self.render(template, options = {})
  text = ERB.new(File.read(template), 0, '-').result

  if options[:to]
    FileUtils.mkdir_p(File.dirname(options[:to]))
    File.write(options[:to], text)
    ret = File.new(options[:to])
  else
    ret = text
  end

  ret
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

def self.quiet?
  ARGV.include?('--quiet') or ARGV.include?('-q')
end

def self.run(*commands)
  options = commands.pop if commands.last.is_a?(Hash)
  options ||= {}

  commands.each do |c|
    masked_command = options[:mask] ? c.gsub(*options[:mask]) : c

    if dry_run?
      puts "command to be run: #{masked_command}" unless quiet?
    else
      puts masked_command unless quiet?
      fail unless system(c)
    end
  end
end

def self.run_itamae(*recipes)
  options = []
  options << '--ohai'
  options << '--log-level=debug' if ENV['DEBUG']

  recipe_files = []
  recipes.each do |recipe|
    recipe = "#{recipe}.rb" unless recipe.end_with?('.rb')
    recipe_files << File.join(cookbook_dir, recipe)
  end

  run "bundle exec itamae local #{options.join(' ')} #{recipe_files.join(' ')}"
end