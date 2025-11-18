require 'rake'
require 'erb'
require 'yaml'
require 'highline'
require File.expand_path('../../daddy/version', __FILE__)

require 'i18n'
I18n.load_path += Dir.glob(File.expand_path('../../tasks/locale/*.yml', __FILE__))
I18n.locale = ENV['LANG'][0..1] if ENV['LANG']

def self.daddy_version
  Daddy::VERSION
end

def self.cli
  @_cli ||= HighLine.new
end

def self.rails_root
  ENV['RAILS_ROOT'] || @_rails_root ||= ask('RAILS_ROOT', :default => Dir.pwd)
end

def self.rails_env(options = {})
  ret = ENV['RAILS_ENV']
  unless ret
    cli.say('RAILS_ENV')
    @_rails_env ||= cli.choose do |menu|
      menu.choice 'production'
      menu.choice 'development'
      menu.choice 'test'
      menu.prompt = 'select number above [2]'
      menu.default = 'development'
    end
  end
end

def self.app_name
  ENV['APP_NAME'] || @_app_name ||= ask('APP_NAME', :default => File.basename(Dir.pwd))
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
  text = ERB.new(File.read(template), trim_mode: '-').result

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
  answer = options[:default] if answer.empty?

  if options[:password]
    system("stty echo")
    puts
  end

  if options[:required] and answer.to_s.empty?
    raise "必須です。処理を中止します。"
  end

  answer.to_s.empty? ? nil : answer
end

def self.ask_env(key, options = {})
  answer = ask(key, options)
  ENV[key] ||= answer if answer
  answer
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

# Database helper methods for dad:db namespace
module DatabaseHelpers
  # Helper method to check if a configuration is multiple databases (Rails 8 style)
  def multiple_databases?(props)
    return false unless props.is_a?(Hash)
    # Standard Rails database config keys
    standard_keys = ['adapter', 'collation', 'database', 'encoding', 'host', 'max_connections', 'migrations_paths', 'password', 'port', 'url', 'username']
    # If it has a 'database' key directly, it's a single database config
    return false if props.key?('database')
    # If it has keys that are not standard keys and those values are hashes with 'database' keys, it's multiple databases
    props.any? do |key, value|
      !standard_keys.include?(key.to_s) && value.is_a?(Hash) && value.key?('database')
    end
  end

  # Helper method to write database creation SQL commands
  def create_database_sql(database, username)
    system("echo 'drop database if exists #{database};' >> tmp/create_databases.sql")
    system("echo 'create database #{database};' >> tmp/create_databases.sql")
    system("echo 'grant all on #{database}.* to \"#{username}\"@\"%\";' >> tmp/create_databases.sql")

    if ENV['FILE']
      system("echo 'grant all on #{database}.* to \"#{username}\"@localhost;' >> tmp/create_databases.sql")
      system("echo 'grant file on *.* to \"#{username}\"@localhost;' >> tmp/create_databases.sql")
    end
  end
end