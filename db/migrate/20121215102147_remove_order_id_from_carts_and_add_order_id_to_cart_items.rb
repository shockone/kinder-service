class RemoveOrderIdFromCartsAndAddOrderIdToCartItems < ActiveRecord::Migration
  def change
    remove_column :carts, :order_id
    add_column :cart_items, :order_id, :integer
  end

end
