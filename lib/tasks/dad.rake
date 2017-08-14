require_relative 'task_helper'

task :dad do
  `rake -aT`.force_encoding('UTF-8').split("\n").each do |line|
    if /rake dad(:.*)?/ =~ line
      puts line
    end
  end
end
