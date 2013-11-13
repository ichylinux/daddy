# coding: UTF-8

require 'rake'
require 'erb'

unless defined?(Rails)
  task :environment do; end
end

namespace :dad do
  namespace :generate do

    task :controller do
      ARGV[1..-1].each do |arg|
        unless arg.index('=')
          task arg.to_sym do ; end
          
          if @resources.nil?
            @resources = arg.downcase
          end
        end
      end

      template = File.join(File.dirname(__FILE__), 'templates', 'controller.rb.erb')
      controller_file = "#{Rails.root}/app/controllers/#{@resources}_controller.rb"
      File.write(controller_file, ERB.new(File.read(template)).result)
    end
    
  end
end
