# coding: UTF-8
require 'rake'

task :dad do
  system('rake -aT | grep dad:')
end
