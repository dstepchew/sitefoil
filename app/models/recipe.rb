# == Schema Information
#
# Table name: recipes
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  status          :string(255)
#  hits            :integer
#  description     :text
#  created_at      :datetime
#  updated_at      :datetime
#  site_id         :integer
#  trigger_id      :string(255)
#  act_id          :string(255)
#  trig_channel_id :string(255)
#  act_channel_id  :string(255)
#  js              :text
#

class Recipe < ActiveRecord::Base
	 attr_protected []

	 has_one :trigger
	# has_one :channels, through :trigger
	 has_one :act

	 belongs_to :site
end
