# coding: UTF-8

require 'rake'
require 'erb'

namespace :dad do
  namespace :generate do

    task :view => :environment do
      ARGV[1..-1].each do |arg|
        unless arg.index('=')
          task arg.to_sym do ; end
          
          if @resources.nil?
            @resources = arg.downcase
          end
        end
      end

      @model_class = @resources.singularize.capitalize.constantize
      @tag_begin = '<%'
      @tag_end = '%>'

      Dir[File.join(File.dirname(__FILE__), 'templates/*.html.erb')].each do |template|
        view_dir = "#{Rails.root}/app/views/#{@resources}"
        FileUtils.mkdir_p(view_dir)

        view_file = "#{view_dir}/#{File.basename(template)}"
        File.write(view_file, ERB.new(File.read(template)).result)
      end
    end
    
  end
end
