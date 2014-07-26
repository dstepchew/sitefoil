class AddTriggerChannelToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :trig_channel_id, :string
  end
end
