class AddBodyAndImageToBanners < ActiveRecord::Migration
  def change
    add_attachment :banners, :image
    add_column :banners, :title, :string
  end
end
