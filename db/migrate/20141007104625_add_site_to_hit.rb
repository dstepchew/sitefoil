class AddSiteToHit < ActiveRecord::Migration
  def change
    add_reference :hits, :site, index: true
  end
end
