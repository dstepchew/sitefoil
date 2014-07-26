class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :name
      t.text :description
      t.string :channel_id

      t.timestamps
    end
  end
end
