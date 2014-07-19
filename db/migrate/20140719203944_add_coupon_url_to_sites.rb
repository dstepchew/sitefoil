class AddCouponUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :coupon_url, :string
  end
end
