# coding: UTF-8

require 'rake/testtask'

desc 'サンプルアプリを実行します。'
task :sample do |t|
  if ENV['SAMPLE_NO']
    samples = ENV['SAMPLE_NO'] 
  else
    samples = [ 1 ] 
  end
  
  samples.each do |sample_no|
    system("cd sample_#{sample_no} && bundle exec rake cucumber")
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task :default => :test
