# coding: UTF-8

module Daddy
  module Cucumber
    module Capture
      SCREENSHOT_DIR = 'features/reports/screenshots'
      FileUtils.mkdir_p(SCREENSHOT_DIR)
    
      @@_screen_count = 0
    
      def capture(url = nil)
        pause
    
        url ||= remove_domain(current_url)
    
        @@_screen_count += 1
    
        image = "#{@@_screen_count}.png"
    
        if Capybara.current_driver == :selenium
          page.driver.browser.save_screenshot("#{SCREENSHOT_DIR}/#{image}")
        else
          page.driver.render("#{SCREENSHOT_DIR}/#{image}")
        end

        puts %{
          <div>#{url}</div>
          <img class="screenshot" src="screenshots/#{image}"/>
        }
      end
    end
  end
end

World(Daddy::Cucumber::Capture)
