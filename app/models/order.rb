class Order < ActiveRecord::Base
  attr_accessible :address, :comment, :phone, :cart_items_attributes
  has_many :cart_items, dependent: :destroy
  accepts_nested_attributes_for :cart_items
  validates_presence_of :address, :phone
end
