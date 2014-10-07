class AddOrderUrlToSite < ActiveRecord::Migration
  def change
    add_column :sites, :order_url, :string
  end
end
