module Daddy
  module Cucumber
    module Puts
      
      def pre(string)
        puts "<pre>#{string}</pre>"
      end

    end
  end
end

World(Daddy::Cucumber::Puts)
