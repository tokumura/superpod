class AddImageIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :image_id, :string
  end
end
