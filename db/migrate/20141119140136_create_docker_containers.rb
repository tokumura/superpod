class CreateDockerContainers < ActiveRecord::Migration
  def change
    create_table :docker_containers do |t|

      t.timestamps
    end
  end
end
