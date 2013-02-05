#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def admins_only_page
    redirect_to root_path, alert: 'Сторінка доступна тільки адміністраторам' unless user_signed_in? and current_user.admin?
  end

  def get_cart(eager_load_items = false)
    if eager_load_items
      Cart.includes(cart_items: :item).find(session[:cart_id])
    else
      Cart.find session[:cart_id]
    end
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def cart_items_with_amount
    item_to_amount = {}
    get_cart(eager_load_items = true).cart_items.sort_by(&:created_at).each { |x| item_to_amount[x.item] = x.amount }
    item_to_amount
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
  end

  def discount?(item)
    not item.special_offer? and not item.category.is_or_is_descendant_of?(Category.find_by_name 'Харчування')
  end

  def discount_class(item)
    discount?(item) ? 'discount' : ''
  end

  def get_banners
    Banner.order('id desc').all
  end

  helper_method :get_cart, :cart_items_with_amount, :sort_direction, :discount_class, :get_banners
end
