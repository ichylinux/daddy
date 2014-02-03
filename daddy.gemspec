# coding: UTF-8

Gem::Specification.new do |s|
  s.name        = 'daddy'
  s.version     = '0.1.26'
  s.date        = '2014-02-03'
  s.summary     = "My rails dad"
  s.description = "Daddy helps me build rails applications since daddy knows some good practices."
  s.license     = 'MIT'
  s.authors     = ["ichy"]
  s.email       = 'ichylinux@gmail.com'
  s.homepage    = 'https://github.com/ichylinux/daddy'
  s.files       = Dir['lib/**/*'] + Dir['vendor/**/*']
  s.executables << 'dad'

  s.add_runtime_dependency 'capybara', '~> 2.2'
  s.add_runtime_dependency 'cucumber', '~> 1.3'
  s.add_runtime_dependency 'cucumber-rails', '~> 1.4'
  s.add_runtime_dependency 'ci_reporter', '~> 1.9'
  s.add_runtime_dependency 'database_cleaner', '~> 1.2'
  s.add_runtime_dependency 'differ', '~> 0'
  s.add_runtime_dependency 'execjs', '~> 2.0' if s.platform.to_s == 'ruby'
  s.add_runtime_dependency 'faraday', '~> 0'
  s.add_runtime_dependency 'holiday_jp', '~> 0'
  s.add_runtime_dependency 'poltergeist', '~> 1.5'
  s.add_runtime_dependency 'rails', '~> 3.2', '>= 3.2.0'
  s.add_runtime_dependency 'rails-i18n', '~> 3.0'
  s.add_runtime_dependency 'selenium-webdriver', '~> 2.39'
  s.add_runtime_dependency 'simplecov', '~> 0'
  s.add_runtime_dependency 'simplecov-rcov', '~> 0'
  s.add_runtime_dependency 'term-ansicolor', '~> 1.2'

  s.add_development_dependency 'rails-csv-fixtures', '~> 0'
end
