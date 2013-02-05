#encoding: utf-8
class BannersController < ApplicationController
  before_filter :admins_only_page

  # GET /banners
  # GET /banners.json
  def index
    @page_title = 'Баннери'
    @banners = Banner.order('id desc').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @banners }
    end
  end

  # GET /banners/new
  # GET /banners/new.json
  def new
    @banner = Banner.new
    @page_title = 'Новий баннер'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @banner }
    end
  end

  # GET /banners/1/edit
  def edit
    @page_title = 'Редагувати баннер'
    @banner = Banner.find(params[:id])
  end

  # POST /banners
  # POST /banners.json
  def create
    @banner = Banner.new(params[:banner])

    respond_to do |format|
      if @banner.save
        format.html { redirect_to root_path }
        format.json { render json: @banner, status: :created, location: @banner }
      else
        flash[:alert] = 'Не вдалось створити баннер'
        format.html { render action: "new" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /banners/1
  # PUT /banners/1.json
  def update
    @banner = Banner.find(params[:id])

    respond_to do |format|
      if @banner.update_attributes(params[:banner])
        format.html { redirect_to root_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @banner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banners/1
  # DELETE /banners/1.json
  def destroy
    @banner = Banner.find(params[:id])
    @banner.destroy

    respond_to do |format|
      format.html { redirect_to banners_url }
      format.json { head :no_content }
    end
  end
end
