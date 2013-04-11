module ApplicationHelper

  def html_line_break(s)
    ret = html_escape(s)
    ret.gsub(/\r\n|\r|\n/, "<br/>").html_safe
  end

end
