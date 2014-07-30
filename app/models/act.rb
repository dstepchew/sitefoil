# == Schema Information
#
# Table name: acts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  channel_id  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Act < ActiveRecord::Base

	belongs_to :recipe
	belongs_to :channel
	has_many :ingredients
end
