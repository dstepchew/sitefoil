class AddJsToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :js, :text
  end
end
