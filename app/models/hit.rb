# == Schema Information
#
# Table name: hits
#
#  id          :integer          not null, primary key
#  ip          :string(255)
#  country     :string(255)
#  state       :string(255)
#  city        :string(255)
#  browser     :string(255)
#  language    :string(255)
#  device_type :string(255)
#  visitor_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  referrer    :string(255)
#

class Hit < ActiveRecord::Base
	belongs_to :visitor, touch: true
end
