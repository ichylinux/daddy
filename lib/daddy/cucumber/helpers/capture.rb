module Daddy
  module Cucumber
    module Capture
      feature_dir = 'features'
      ARGV.each_with_index do |arg, i|
        if arg == '-r'
          feature_dir = ARGV[i + 1]
          break
        end
      end
      REPORT_DIR = File.join(feature_dir, 'reports')
      IMAGE_DIR = 'images'
      FileUtils.mkdir_p("#{REPORT_DIR}/#{IMAGE_DIR}")
    
      @@_screen_count = 0
      @@_images = []
    
      def capture(options = {})
        options ||= {}
        options = {:title => options} if options.is_a?(String)

        pause
        return if ENV['FORMAT'] == 'junit'

        url = Rack::Utils.unescape(current_url)
    
        @@_screen_count += 1

        image = "#{IMAGE_DIR}/#{@@_screen_count}.png"
        page.driver.save_screenshot("#{REPORT_DIR}/#{image}", :full => true)

        image_tag = "<img class=\"screenshot\" src=\"#{image}\" title=\"#{options[:title]}\" alt=\"#{url}\"/>"

        if options[:flash]
          puts image_tag
        else
          @@_images << image_tag
        end
      end

      def resize_window(width, height)
        case Capybara.current_driver
        when :poltergeist
          Capybara.current_session.driver.resize(width, height)
        when :selenium
          Capybara.current_session.driver.browser.manage.window.resize_to(width, height)
        when :webkit
          # TODO
        end
      end

      def flash_image_tags
        if @@_images.size > 0
          puts @@_images.join("\n")
          @@_images.clear
        end
      end

    end
  end
end

World(Daddy::Cucumber::Capture)

AfterStep do |step|
  flash_image_tags
end
