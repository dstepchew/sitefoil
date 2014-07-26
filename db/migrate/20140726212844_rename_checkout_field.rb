class RenameCheckoutField < ActiveRecord::Migration
  def change

  	change_table :sites do |t|
      t.rename :chekout_url, :checkout_url
  	end
  end
end
