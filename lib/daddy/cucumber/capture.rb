# coding: UTF-8

module Daddy
  module Cucumber
    module Capture
      REPORT_DIR = 'features/reports'
      IMAGE_DIR = 'images'
      FileUtils.mkdir_p("#{REPORT_DIR}/#{IMAGE_DIR}")
    
      @@_screen_count = 0
      @@_browser_resized = false
    
      def capture
        pause

        url = Rack::Utils.unescape(current_url)
    
        @@_screen_count += 1
    
        image = "#{IMAGE_DIR}/#{@@_screen_count}.png"
        page.driver.save_screenshot("#{REPORT_DIR}/#{image}")

        puts %{
          <div>#{url}</div>
          <img class="screenshot" src="#{image}"/>
        }
      end

      def resize_window(width, height)
        unless @@_browser_resized
          case Capybara.current_driver
          when :poltergeist
            # TODO
          when :selenium
            Capybara.current_session.driver.browser.manage.window.resize_to(width, height)
          when :webkit
            # TODO
          end

          @@_browser_resized = true
        end
      end

    end
  end
end

World(Daddy::Cucumber::Capture)
