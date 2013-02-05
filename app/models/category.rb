class Category < ActiveRecord::Base
  has_many :items
  acts_as_nested_set
  attr_accessible :name
  validates_presence_of :name
end