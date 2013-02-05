class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      #required columns for nested_set
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
end
