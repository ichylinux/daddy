$:.push File.expand_path("../lib", __FILE__)
require 'daddy/version'

Gem::Specification.new do |s|
  s.name        = 'daddy'
  s.version     = Daddy::VERSION
  s.summary     = "My rails dad"
  s.description = "Daddy helps me build web applications since daddy knows some good practices."
  s.license     = 'MIT'
  s.authors     = ["ichy"]
  s.email       = 'ichylinux@gmail.com'
  s.homepage    = 'https://github.com/ichylinux/daddy'
  s.files       = Dir['app/**/*'] +
                  Dir['itamae/**/*'] +
                  Dir['lib/**/*'] +
                  Dir['ssl/**/*'] +
                  Dir['templates/**/*'] +
                  Dir['vendor/**/*']
  s.require_paths = ['lib']

  s.required_ruby_version = '~> 2.5'

  s.add_runtime_dependency 'docker-api'
  s.add_runtime_dependency 'highline'
  s.add_runtime_dependency 'i18n'
  s.add_runtime_dependency 'itamae'
  s.add_runtime_dependency 'itamae-plugin-recipe-daddy'
  s.add_runtime_dependency 'itamae-plugin-resource-pip'
  s.add_runtime_dependency 'ohai'

  s.add_development_dependency 'ci_reporter'
  s.add_development_dependency 'closer'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'faraday'
  s.add_development_dependency 'faraday_middleware'
  s.add_development_dependency 'rails'
  s.add_development_dependency 'redis'
  s.add_development_dependency 'redis-namespace'
  s.add_development_dependency 'resque'
  s.add_development_dependency 'resque-scheduler'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'simplecov-rcov'
end
