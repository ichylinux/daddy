# coding: UTF-8

require 'rake/testtask'

desc 'サンプルアプリを実行します。'
task :sample do |t|
  fail 'SAMPLE_NO を指定してください。' unless ENV['SAMPLE_NO']
  sample = "sample_#{ENV['SAMPLE_NO']}"
  system("cd #{sample} && cucumber")
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task :default => :test
