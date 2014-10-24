class ChangeRecipeSiteId < ActiveRecord::Migration
  def change
  	remove_column :recipes, :site_id
  	add_column :recipes, :site_id, :integer
  end
end
