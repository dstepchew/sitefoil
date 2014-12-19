class AddTimezoneToSite < ActiveRecord::Migration
  def change
    add_column :sites, :timezone, :float
  end
end
