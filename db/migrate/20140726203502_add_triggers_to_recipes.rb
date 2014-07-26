class AddTriggersToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :trigger_id, :string
  end
end
