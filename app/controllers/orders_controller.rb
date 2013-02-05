#encoding: utf-8
class OrdersController < ApplicationController
  before_filter :admins_only_page, except: [:new, :create]

  def index
    @page_title = 'Список замовлень'
    @orders = Order.where(completed: false).includes(:cart_items).order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
    @orders_discount = {}
    @orders.each { |order| @orders_discount[order.id] = discount(order.cart_items) }
  end

  def archive
    @page_title = 'Архів замовлень'
    @orders = Order.where(completed: true).order('updated_at desc').paginate(page: params[:page], per_page: 20)
    @orders_discount = {}
    @orders.each { |order| @orders_discount[order.id] = discount(order.cart_items) }
  end

  def new
    @page_title = 'Замовлення'
    @order = Order.new
    @order.cart_items << get_cart.cart_items
    if user_signed_in?
      @order.address = current_user.address
      @order.phone = current_user.phone
    end
  end

  def create
    @order = Order.new
    get_cart.cart_items.each do |cart_item|
      cart_item.update_attribute :cart_id, nil
      @order.cart_items << cart_item
    end
    @order.update_attributes params[:order]
    @order.total = @order.cart_items.map { |cart_item| cart_item.item.price * cart_item.amount }.sum
    if user_signed_in?
      current_user.update_attributes address: params[:order][:address], phone: params[:order][:phone]
    end
    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to items_path, notice: 'Дякуємо за ваше замовлення. Наш менеджер вам зателефонує.'
    else
      render action: 'new'
    end
  end

  def complete
    order = Order.find(params[:id])
    order.completed = true
    order.save
    redirect_to :back
  end


  def destroy
    Order.destroy(params[:id])
    redirect_to :back
  end

  private

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  #Given an array of cart_items returns hash with discount :percent and :value
  def discount(cart_items)
    total = cart_items.select { |cart_item| discount? cart_item.item }.inject(0) do |accum, cart_item|
      accum + (cart_item.amount * cart_item.item.price)
    end
    dsc = {}
    dsc[:percent] = if total >= 530
      5
    elsif total >= 310
      3
    else
      0
    end
    dsc[:value] = (total * dsc[:percent]).floor / 100.0
    dsc
  end

  #sort_direction moved to application_controller

  helper_method :sort_column
end