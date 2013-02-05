class CartsController < ApplicationController

  def add
    get_cart.cart_items.find_by_item_id!(params[:item_id]).increment! :amount
  rescue ActiveRecord::RecordNotFound
    get_cart.cart_items.create(item_id: params[:item_id])
  ensure
    respond_to do |format|
      format.html {redirect_to :back}
      format.js { render 'carts/change'}
    end
  end

  def remove
    get_cart.cart_items.find_by_item_id!(params[:item_id]).destroy
    respond_to do |format|
      format.html {redirect_to :back}
      format.js { render 'carts/change'}
    end
  end

  def destroy
    Cart.destroy(session[:cart_id])
    respond_to do |format|
      format.html {redirect_to :back}
      format.js { render 'carts/change'}
    end
  end
end
