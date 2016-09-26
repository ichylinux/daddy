$:.push File.expand_path("../lib", __FILE__)
require 'daddy/version'

Gem::Specification.new do |s|
  s.name        = 'daddy'
  s.version     = Daddy::VERSION
  s.date        = Date.today
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
  s.executables << 'dad'

  s.required_ruby_version = '~> 2.0'

  s.add_runtime_dependency 'capybara', '~> 2.7'
  s.add_runtime_dependency 'closer', '~> 0.3'
  s.add_runtime_dependency 'ci_reporter', '~> 2.0'
  s.add_runtime_dependency 'faraday', '~> 0.9'
  s.add_runtime_dependency 'holiday_jp', '~> 0.4'
  s.add_runtime_dependency 'i18n', '~> 0.7'
  s.add_runtime_dependency 'itamae', '~> 1.9'
  s.add_runtime_dependency 'ohai', '~> 8.10'
  s.add_runtime_dependency 'poltergeist', '~> 1.9'
  s.add_runtime_dependency 'rails', '~> 4.1'
  s.add_runtime_dependency 'resque', '~> 1.25'
  s.add_runtime_dependency 'resque-scheduler', '~> 4.0'
  s.add_runtime_dependency 'selenium-webdriver', '~> 2.51'
  s.add_runtime_dependency 'simplecov', '~> 0.11'
  s.add_runtime_dependency 'simplecov-rcov', '~> 0.2'

  s.add_development_dependency 'database_cleaner', '~> 1.5'
end
