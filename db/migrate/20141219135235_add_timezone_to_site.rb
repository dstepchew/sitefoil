class AddTimezoneToSite < ActiveRecord::Migration
  def change
    add_column :sites, :timezone_minutes, :integer, :default=>0
  end
end
