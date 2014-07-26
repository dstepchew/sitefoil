class AddCouponIdToSites < ActiveRecord::Migration
  def change
    add_column :sites, :coupon_id, :string
  end
end
