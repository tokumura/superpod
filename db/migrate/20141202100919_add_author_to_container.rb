class AddAuthorToContainer < ActiveRecord::Migration
  def change
    add_column :containers, :author, :string
  end
end
