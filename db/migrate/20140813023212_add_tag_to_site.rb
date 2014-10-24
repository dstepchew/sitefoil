class AddTagToSite < ActiveRecord::Migration
  def change
    add_column :sites, :tag, :text
  end
end
