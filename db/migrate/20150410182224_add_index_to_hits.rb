class AddIndexToHits < ActiveRecord::Migration
  def change
    add_index "hits", ["visitor_id"]
  end
end
