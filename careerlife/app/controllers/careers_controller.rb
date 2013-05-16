# coding: UTF-8

class CareersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if current_user.career
      redirect_to career_path(current_user.career)
      return
    end
  end

  def show
    @career = Career.find(params[:id])
  end

  def new
    @career = current_user.build_career
  end
  
  def new_career_detail
    @career_detail = CareerDetail.new
    render :partial => 'career_detail_fields', :locals => {:career_detail => @career_detail, :index => params[:index]}
  end

  def edit
    @career = Career.find(params[:id])
  end

  def create
    @career = Career.new(params[:career])

    if @career.save
      redirect_to @career, notice: t('messages.created', :name => Career.model_name.human)
    else
      render action: "new"
    end
  end

  def update
    @career = Career.find(params[:id])

    if @career.update_attributes(params[:career])
      redirect_to @career, notice: t('messages.updated', :name => Career.model_name.human)
    else
      render action: "edit"
    end
  end

  def destroy
    @career = Career.find(params[:id])
    @career.destroy

    redirect_to careers_url, notice: t('messages.deleted', :name => Career.model_name.human)
  end
end
