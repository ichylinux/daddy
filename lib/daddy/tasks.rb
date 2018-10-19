require 'closer/tasks' if defined?(Closer)

Dir[File.join(File.dirname(File.dirname(__FILE__)), 'tasks', '*.rake')].each do |f|
  load f
end
