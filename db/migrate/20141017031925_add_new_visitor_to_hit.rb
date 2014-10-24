class AddNewVisitorToHit < ActiveRecord::Migration
  def change
    add_column :hits, :new_visitor, :boolean
  end
end
