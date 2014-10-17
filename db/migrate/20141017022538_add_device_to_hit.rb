class AddDeviceToHit < ActiveRecord::Migration
  def change
    add_column :hits, :device, :string
  end
end
