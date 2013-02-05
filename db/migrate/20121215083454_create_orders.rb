class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.string :phone
      t.text :comment

      t.timestamps
    end

    add_column :carts, :order_id, :integer
  end
end
