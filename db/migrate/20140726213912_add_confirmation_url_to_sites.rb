class AddConfirmationUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :confirmation_url, :string
  end
end
