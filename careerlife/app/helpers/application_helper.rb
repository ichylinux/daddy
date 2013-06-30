module ApplicationHelper
  include Daddy::Helpers::HtmlHelper

  def render_errors(model)
    render :partial => 'common/errors', :locals => {:model => model}
  end
end
