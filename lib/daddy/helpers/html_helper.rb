# coding: UTF-8

module Daddy
  module Helpers

    module HtmlHelper

      def html_line_break(s)
        ret = html_escape(s)
        ret.gsub(/\r\n|\r|\n/, "<br/>").html_safe
      end

    end

  end
end
