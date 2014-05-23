require 'rake'
require 'erb'

namespace :dad do
  namespace :generate do

    task :controller => :environment do
      ARGV[1..-1].each do |arg|
        unless arg.index('=')
          task arg.to_sym do ; end
          
          if @resources.nil?
            @resources = arg.downcase
          end
        end
      end

      @resource = @resources.singularize
      @model_class = @resource.classify.constantize
      @controller_name = @resources.split('_').map{|a| a.capitalize}.join

      template = File.join(File.dirname(__FILE__), 'templates', 'controller.rb.erb')
      controller_file = "#{Rails.root}/app/controllers/#{@resources}_controller.rb"
      File.write(controller_file, ERB.new(File.read(template)).result)
    end
    
  end
end
