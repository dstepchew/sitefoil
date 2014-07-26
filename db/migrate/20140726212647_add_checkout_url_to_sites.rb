class AddCheckoutUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :chekout_url, :string
  end
end
