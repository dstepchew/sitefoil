class AddStatusToSites < ActiveRecord::Migration
  def change
    add_column :sites, :status, :string
  end
end
