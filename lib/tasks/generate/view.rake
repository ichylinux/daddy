require 'rake'

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

      @resource = @resources.singularize
      @short_name = @resource.split('_').map(&:first).join
      @model_class = @resource.capitalize.constantize
      @tag_begin = '<%'
      @tag_end = '%>'

      Dir[File.join(template_dir, 'app', 'views', '*.html.erb')].each do |template|
        view_dir = "#{Rails.root}/app/views/#{@resources}"
        FileUtils.mkdir_p(view_dir)

        view_file = "#{view_dir}/#{File.basename(template)}"
        File.write(view_file, ERB.new(File.read(template), 0, '-').result)
      end
    end
    
  end
end
