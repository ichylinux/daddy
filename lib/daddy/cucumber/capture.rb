# coding: UTF-8

module Daddy
  module Cucumber
    module Capture
      REPORT_DIR = File.join('features', 'reports')
      IMAGE_DIR = 'images'
      FileUtils.mkdir_p("#{REPORT_DIR}/#{IMAGE_DIR}")
    
      @@_screen_count = 0
      @@_images = []
    
      def capture(options = {})
        pause
        return if ENV['FORMAT'] == 'junit'

        url = Rack::Utils.unescape(current_url)
    
        @@_screen_count += 1

        image = "#{IMAGE_DIR}/#{@@_screen_count}.png"
        page.driver.save_screenshot("#{REPORT_DIR}/#{image}", :full => true)

        if options[:flash]
          puts "<img class=\"screenshot\" src=\"#{image}\" alt=\"#{url}\"/>"
        else
          @@_images << "<img class=\"screenshot\" src=\"#{image}\" alt=\"#{url}\"/>"
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
        puts @@_images.join("\n")
        @@_images.clear
      end

    end
  end
end

World(Daddy::Cucumber::Capture)

AfterStep do |step|
  flash_image_tags
end
