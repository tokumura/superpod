class CreateDockerImages < ActiveRecord::Migration
  def change
    create_table :docker_images do |t|

      t.timestamps
    end
  end
end
