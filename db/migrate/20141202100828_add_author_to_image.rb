class AddAuthorToImage < ActiveRecord::Migration
  def change
    add_column :images, :author, :string
  end
end
