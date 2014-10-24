class AddOsNameToHit < ActiveRecord::Migration
  def change
    add_column :hits, :os_name, :string
  end
end
