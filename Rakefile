# coding: UTF-8

task :build do |t|
  [
    "rm -f daddy-*.gem",
    "gem build daddy.gemspec",
  ].each do |command|
    puts command
    system command
  end

  Dir.glob(File.dirname(__FILE__) + '/daddy-*.gem').each do |gem|
    command = "sudo gem install --local #{gem}"
    puts command
    system command
  end
end

task :test do |t|
  system "cd careerlife && rake test"
end

task :default => :test
