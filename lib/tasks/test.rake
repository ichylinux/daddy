# coding: UTF-8

require 'rake'

Rake::Task["test"].clear

task :test => :environment do
  Rake::Task["dad:cucumber"].execute
end