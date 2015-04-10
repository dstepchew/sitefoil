class AddIndexToRecipe < ActiveRecord::Migration
  def change
    add_index "recipes", ["site_id"]
    add_index "recipes", ["site_id","enabled"]
    add_index "recipes", ["enabled"]
  end
end
