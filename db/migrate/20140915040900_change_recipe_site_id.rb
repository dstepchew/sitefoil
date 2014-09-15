class ChangeRecipeSiteId < ActiveRecord::Migration
  def change
  	change_column :recipes, :site_id, :integer
  end
end
