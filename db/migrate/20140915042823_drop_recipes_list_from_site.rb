class DropRecipesListFromSite < ActiveRecord::Migration
  def change
  	remove_column :sites, :recipes_list
  end
end
