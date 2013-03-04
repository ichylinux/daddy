# coding: UTF-8

Gem::Specification.new do |s|
  s.name        = 'daddy'
  s.version     = '0.0.1'
  s.date        = '2013-03-02'
  s.summary     = "My rails dad"
  s.description = "Dadday helps me build rails applications since daddy knows some best practices."
  s.authors     = ["ichy"]
  s.email       = 'ichylinux@gmail.com'
  s.files       = ["lib/daddy.rb"]
  s.homepage    = 'https://github.com/ichylinux/daddy'
  s.add_runtime_dependency 'rails', ['~> 3.2.0']
  s.add_runtime_dependency 'cucumber'
end
