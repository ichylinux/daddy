# coding: UTF-8

class ProfilesController < ApplicationController

  def index
    redirect_to :action => 'show', :id => current_user.id
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    
    begin
      @user.update_attributes!(params[:user])
      redirect_to :action => 'show', :id => @user.id
      
    rescue ActiveRecord::RecordInvalid => e
      render :action => 'edit', :id => @user.id
    end
  end

end
