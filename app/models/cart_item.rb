class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item
  belongs_to :order
  validates_numericality_of :amount, greater_than: 0, only_integer: true

  attr_accessible :item_id, :amount, :item_attributes
  accepts_nested_attributes_for :item
end
