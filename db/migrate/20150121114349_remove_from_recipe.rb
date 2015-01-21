class RemoveFromRecipe < ActiveRecord::Migration
  def change
  	remove_column :recipes, :trigger_id
  	remove_column :recipes, :act_id
  	remove_column	:recipes, :trig_channel_id
  	remove_column :recipes, :act_channel_id
  end
end
