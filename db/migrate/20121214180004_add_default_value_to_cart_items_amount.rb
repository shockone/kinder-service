class AddDefaultValueToCartItemsAmount < ActiveRecord::Migration
  def change
    remove_column :cart_items, :amount
    add_column :cart_items, :amount, :integer, default: 1
  end
end
