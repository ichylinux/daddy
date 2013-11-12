# coding: UTF-8

Gem::Specification.new do |s|
  s.name        = 'daddy'
  s.version     = '0.1.19'
  s.date        = '2013-11-12'
  s.summary     = "My rails dad"
  s.description = "Daddy helps me build rails applications since daddy knows some good practices."
  s.license     = 'MIT'
  s.authors     = ["ichy"]
  s.email       = 'ichylinux@gmail.com'
  s.files       = Dir['lib/**/*']
  s.homepage    = 'https://github.com/ichylinux/daddy'

  s.add_runtime_dependency 'capybara'
  s.add_runtime_dependency 'cucumber'
  s.add_runtime_dependency 'cucumber-rails'
  s.add_runtime_dependency 'ci_reporter'
  s.add_runtime_dependency 'database_cleaner'
  s.add_runtime_dependency 'differ'
  s.add_runtime_dependency 'execjs' if s.platform.to_s == 'ruby'
  s.add_runtime_dependency 'faraday'
  s.add_runtime_dependency 'poltergeist'
  s.add_runtime_dependency 'rails', ['~> 3.2.0']
  s.add_runtime_dependency 'rails-i18n'
  s.add_runtime_dependency 'selenium-webdriver'
  s.add_runtime_dependency 'simplecov'
  s.add_runtime_dependency 'simplecov-rcov'
  s.add_runtime_dependency 'term-ansicolor'

  s.add_development_dependency 'rails-csv-fixtures'
end
