# coding: UTF-8

module Daddy
  module Cucumber
    module Formatting

      def pre(string)
        puts "<pre>#{string}</pre>"
      end

    end
  end
end

World(Daddy::Cucumber::Formatting)
