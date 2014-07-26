class AddTotalFieldToSites < ActiveRecord::Migration
  def change
    add_column :sites, :total_id, :string
  end
end
