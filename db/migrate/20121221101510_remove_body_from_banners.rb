class RemoveBodyFromBanners < ActiveRecord::Migration
  def change
    remove_column :banners, :body
  end

end
