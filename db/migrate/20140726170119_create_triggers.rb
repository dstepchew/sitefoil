class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.string :name
      t.text :description
      t.string :channel_id

      t.timestamps
    end
  end
end
