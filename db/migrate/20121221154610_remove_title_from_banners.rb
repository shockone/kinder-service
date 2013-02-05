class RemoveTitleFromBanners < ActiveRecord::Migration
  def change
    remove_column :banners, :title
  end

end
