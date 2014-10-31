class AddHitLastTimeToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :hit_last_time, :datetime
  end
end
