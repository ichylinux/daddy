module Daddy
  module Cucumber
    module Pause
      
      def pause(second = nil)
        duration = (second || ENV['PAUSE'] || 1).to_i 
        sleep(duration) if duration > 0
      end
      
      def wait_until
        pause_count = 10
        while pause_count > 0 do
          return true if yield
          pause 1
          pause_count -= 1
        end

        false
      end
    
    end
  end
end

World(Daddy::Cucumber::Pause)
