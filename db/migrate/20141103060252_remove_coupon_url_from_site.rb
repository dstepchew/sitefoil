class RemoveCouponUrlFromSite < ActiveRecord::Migration
  def change
    remove_column :sites, :coupon_url, :string
    remove_column :sites, :coupon_selector, :string
  end
end
