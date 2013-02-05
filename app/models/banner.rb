class Banner < ActiveRecord::Base
  has_attached_file :image
  attr_accessible :image
  validates :image, :attachment_presence => true
end
