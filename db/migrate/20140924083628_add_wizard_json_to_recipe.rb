class AddWizardJsonToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :wizard_json, :text
  end
end
