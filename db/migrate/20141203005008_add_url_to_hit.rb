class AddUrlToHit < ActiveRecord::Migration
  def change
    add_column :hits, :url, :string
  end
end
