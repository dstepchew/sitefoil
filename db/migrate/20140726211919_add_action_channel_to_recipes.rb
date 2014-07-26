class AddActionChannelToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :act_channel_id, :string
  end
end
