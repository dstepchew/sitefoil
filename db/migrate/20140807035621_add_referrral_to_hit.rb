class AddReferrralToHit < ActiveRecord::Migration
  def change
    add_column :hits, :referrer, :string
  end
end
