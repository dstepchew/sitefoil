class AddTagToHit < ActiveRecord::Migration
  def change
    add_column :hits, :tag, :text
  end
end
