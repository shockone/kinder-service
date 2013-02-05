class Item < ActiveRecord::Base
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items
  has_many :orders, through: :cart_items
  attr_accessible :description, :image, :name, :price, :category_id, :special_offer
  validates_presence_of :description, :image, :name, :price, :category
  validates_numericality_of :price, greater_than: 0
  has_attached_file :image, default_url: 'missing.png'

  def in_latests?
    self.created_at > 30.days.ago
  end

  def self.text_search(query)
    if query.present?
      search query
    else
      scoped
    end
  end

  def price=(price)
    if price.class == String
      price = price.gsub(',', '.')
    end
    self[:price] = price
  end
end

