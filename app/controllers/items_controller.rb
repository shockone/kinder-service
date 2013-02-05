# encoding: UTF-8
class ItemsController < ApplicationController
  before_filter :admins_only_page, except: [:index, :latest, :special_offers, :show]

  def index
    @page_title = "пошук «#{params[:query]}»" if params[:query].present?
    @items = Item.text_search(params[:query]).order(sort_column + ' ' + sort_direction).
        order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 20)
  end

  def latest
    @page_title = 'Новинки'
    @items = Item.where('created_at > ?', 30.days.ago).order(sort_column + ' ' + sort_direction).
        paginate(page: params[:page], per_page: 20)
    render 'index'
  end

  def special_offers
    @page_title = 'Акції'
    @items = Item.where(special_offer: true).paginate(page: params[:page], per_page: 20)
    render 'index'
  end

  def show
    @item = Item.find(params[:id])
    @current_category = @item.category
    @page_title = @item.name
  end

  def new
    @page_title = 'Новий товар'
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
    @page_title = "Редагування «#{@item.name}»"
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      redirect_to @item
    else
      render action: "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to @item
    else
      render action: "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_url
  end

  private

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end

  #sort_direction moved to application_controller



  helper_method :sort_column
end
