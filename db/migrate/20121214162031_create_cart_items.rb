class CreateCartItems < ActiveRecord::Migration
  def change
    drop_table :carts_items
    create_table :cart_items do |t|
      t.integer :item_id
      t.integer :cart_id
      t.decimal :price
      t.integer :amount
      t.timestamps
    end
  end
end
