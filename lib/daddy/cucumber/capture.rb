# coding: UTF-8

module Daddy
  module Cucumber
    module Capture
      SCREENSHOT_DIR = 'features/reports/screenshots'
      FileUtils.mkdir_p(SCREENSHOT_DIR)
    
      @@_screen_count = 0
    
      def capture(label = nil)
    
        label ||= remove_domain(current_url)
    
        @@_screen_count += 1
    
        id = "step_img_#{@@_screen_count}"
        src = "screenshots/#{id}.png"
    
        unless Capybara.current_driver == :selenium
          page.driver.render("#{SCREENSHOT_DIR}/#{id}.png")
        else
          page.driver.browser.save_screenshot("#{SCREENSHOT_DIR}/#{id}.png")
        end
    
        link = %{
          URL： #{label}<br/>
          <img id="#{id}" src="#{src}" width="50%" height="50%"/>
        }
    
        puts link
      end
    end
  end
end
