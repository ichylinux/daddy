module ApplicationHelper
  include Daddy::Helpers::HtmlHelper

  def render_errors(model)
    render :partial => 'common/errors', :locals => {:model => model}
  end

  def render_notices
    render :partial => 'common/notices'
  end
end
