class TopController < ApplicationController

  def index
    @careers = Career.all
  end

end
