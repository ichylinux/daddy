class TopController < ApplicationController

  def index
    @condition = CareerCondition.new(params[:career_condition])
    @careers = Career.search(@condition)
  end

end
