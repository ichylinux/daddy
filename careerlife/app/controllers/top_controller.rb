# coding: UTF-8

class TopController < ApplicationController

  def index
    @careers = Career.all
  end

end
