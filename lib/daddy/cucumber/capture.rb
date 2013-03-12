# coding: UTF-8

module Daddy
  module Cucumber
    module Capture
      SCREENSHOT_DIR = 'features/reports/screenshots'
      FileUtils.mkdir_p(SCREENSHOT_DIR)
    
      @@_screen_count = 0
    
      def capture(url = nil)
    
        url ||= remove_domain(current_url)
    
        @@_screen_count += 1
    
        image = "#{@@_screen_count}.png"
    
        if Capybara.current_driver == :webkit
          page.driver.render("#{SCREENSHOT_DIR}/#{image}")
        else
          page.driver.browser.save_screenshot("#{SCREENSHOT_DIR}/#{image}")
        end

        puts %{
          <div style="margin: 5px 0;">#{url}</div>
          <div style="padding-right: 20px;"><img src="screenshots/#{image}" width="60%" height="60%"/></div>
        }
      end
    end
  end
end
