class AddOrganizationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :organization, :string
    add_index :users, :organization
  end
end
