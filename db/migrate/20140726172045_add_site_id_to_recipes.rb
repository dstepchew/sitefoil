class AddSiteIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :site_id, :string
  end
end
