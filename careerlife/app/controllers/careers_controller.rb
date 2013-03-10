class CareersController < ApplicationController
  # GET /careers
  # GET /careers.json
  def index
    @careers = Career.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @careers }
    end
  end

  # GET /careers/1
  # GET /careers/1.json
  def show
    @career = Career.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @career }
    end
  end

  # GET /careers/new
  # GET /careers/new.json
  def new
    @career = Career.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @career }
    end
  end

  # GET /careers/1/edit
  def edit
    @career = Career.find(params[:id])
  end

  # POST /careers
  # POST /careers.json
  def create
    @career = Career.new(params[:career])

    respond_to do |format|
      if @career.save
        format.html { redirect_to @career, notice: 'Career was successfully created.' }
        format.json { render json: @career, status: :created, location: @career }
      else
        format.html { render action: "new" }
        format.json { render json: @career.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /careers/1
  # PUT /careers/1.json
  def update
    @career = Career.find(params[:id])

    respond_to do |format|
      if @career.update_attributes(params[:career])
        format.html { redirect_to @career, notice: 'Career was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @career.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /careers/1
  # DELETE /careers/1.json
  def destroy
    @career = Career.find(params[:id])
    @career.destroy

    respond_to do |format|
      format.html { redirect_to careers_url }
      format.json { head :no_content }
    end
  end
end
