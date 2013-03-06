# coding: UTF-8

require 'rake/testtask'

desc 'サンプルを実行します。'
task :sample do |t|
  if ENV['SAMPLE_NO']
    samples = [ ENV['SAMPLE_NO'] ]
  else
    samples = [ 1 ] 
  end
  
  samples.each do |sample_no|
    dir = "sample_#{sample_no}"
    system("rm -Rf #{dir}/features/reports")
    system("mkdir -p #{dir}/features/reports")
    system("cd #{dir} && bundle exec cucumber -f Daddy::Formatter::Html > features/reports/index.html")
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task :default => :test
