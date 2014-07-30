class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
      t.string :ip
      t.string :country
      t.string :state
      t.string :city
      t.string :browser
      t.string :language
      t.string :device_type
      t.integer :visitor_id

      t.timestamps
    end
  end
end
