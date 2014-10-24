class RenameFieldsInSite < ActiveRecord::Migration
  def change
  	 change_table :sites do |t| 
  	   t.rename :coupon_id, :coupon_selector
  	   t.rename :total_id, :total_selector
  	 end
  end
end
