# == Schema Information
#
# Table name: sites
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  url              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  coupon_url       :string(255)
#  coupon_id        :string(255)
#  status           :string(255)
#  checkout_url     :string(255)
#  total_id         :string(255)
#  confirmation_url :string(255)
#

class Site < ActiveRecord::Base

	 validates_presence_of :user_id, :name, :url
  	 
	belongs_to :user
	has_many :recipes
	has_many :channels
end
