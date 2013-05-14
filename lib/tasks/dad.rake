# coding: UTF-8

require 'rake'

task :dad do
  system('rake -T | grep dad:')
end

namespace :dad do
  task :install do
    system('rake dad:cucumber:install')
  end
end