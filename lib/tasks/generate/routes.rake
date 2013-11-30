# coding: UTF-8

require 'rake'
require 'erb'

namespace :dad do
  namespace :generate do

    task :routes do
      ARGV[1..-1].each do |arg|
        unless arg.index('=')
          task arg.to_sym do ; end
          
          @app_name ||= arg
        end
      end

      template = File.join(File.dirname(__FILE__), 'templates', 'routes.rb.erb')
      routes_file = "#{Rails.root}/config/routes.rb"
      File.write(routes_file, ERB.new(File.read(template)).result)
    end
    
  end
end
