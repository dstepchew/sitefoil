class AddRecipesToSite < ActiveRecord::Migration
  def change
    add_column :sites, :recipes_list, :text
  end
end
