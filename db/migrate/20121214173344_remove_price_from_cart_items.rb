class RemovePriceFromCartItems < ActiveRecord::Migration
  def up
    remove_column :cart_items, :price

  end

  def down
    add_column :cart_items, :price, :decimal
  end
end
