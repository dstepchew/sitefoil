class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :status
      t.integer :hits
      t.text :description

      t.timestamps
    end
  end
end
