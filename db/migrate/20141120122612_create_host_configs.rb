class CreateHostConfigs < ActiveRecord::Migration
  def change
    create_table :host_configs do |t|
      t.string :host
      t.string :port

      t.timestamps
    end
  end
end
