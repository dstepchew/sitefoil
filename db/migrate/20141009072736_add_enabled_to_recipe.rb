class AddEnabledToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :enabled, :boolean, :default=>true
  end
end
