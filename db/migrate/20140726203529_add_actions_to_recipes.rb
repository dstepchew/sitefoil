class AddActionsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :act_id, :string
  end
end
