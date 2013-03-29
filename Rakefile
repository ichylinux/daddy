# coding: UTF-8

task :build do |t|
  cmd = "gem build daddy.gemspec"
  puts cmd
  system cmd

  Dir.glob(File.dirname(__FILE__) + '/daddy-*.gem').each do |gem|
    cmd = "sudo gem install --local #{gem}"
    puts cmd
    system cmd
  end
end

task :test do |t|
  system "cd careerlife && rake test"
end

task :default => :test
