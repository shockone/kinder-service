# encoding: UTF-8
class CategoriesController < ApplicationController
  before_filter :admins_only_page, except: :show

  def index
    @page_title = 'Редактор категорій'
    @category = Category.new
  end

  def show
    @current_category = Category.find(params[:id])
    @items = Item.where(category_id: @current_category.self_and_descendants.map(&:id)).
        order(sort_column + ' ' + sort_direction).
        paginate(page: params[:page], per_page: 20)
    @page_title = @current_category.name
    render 'items/index'
  end

  def new
    @page_title = 'Нова категорія'
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
    @page_title = "Редагування «#{@category.name}»"
  end

  def create
    if params[:commit] == 'Добавити'
      @category = Category.new(params[:category])
      if @category.save
        redirect_to :back, notice: 'Категорію добавлено. Ви можете знайти її в кінці списку.'
      else
        render action: 'index'
      end
    else
      params[:_json].each do |c|
        ActiveRecord::Base.connection.execute(
            "UPDATE categories SET lft = #{c[:lft]}, rgt = #{c[:rgt]}, parent_id = #{c[:parent_id] || 'NULL'} where id = #{c[:id]}")
      end
      render 'categories/change'
    end
  end

  def update

    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to @category
    else
      render action: "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to :back
  end

  private

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  helper_method :sort_column
end
