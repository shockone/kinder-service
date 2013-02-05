class AddSpecialOfferToItems < ActiveRecord::Migration
  def change
    add_column :items, :special_offer, :boolean
  end
end
