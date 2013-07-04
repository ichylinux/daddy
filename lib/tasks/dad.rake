# coding: UTF-8

require 'rake'

task :dad do
  system('rake -aT | grep dad:')
end

namespace :dad do
  task :install do
    system('rake dad:cucumber:install')
  end
end