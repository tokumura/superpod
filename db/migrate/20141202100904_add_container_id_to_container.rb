class AddContainerIdToContainer < ActiveRecord::Migration
  def change
    add_column :containers, :container_id, :string
  end
end
