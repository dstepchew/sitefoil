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
#  wizard_json     :text
#  enabled         :boolean          default(TRUE)
#

class Recipe < ActiveRecord::Base
	attr_protected []

	has_one :trigger
	# has_one :channels, through :trigger
	has_one :act

	belongs_to :site

	def name_or_action
		return self['name'] if !self['name'].blank?
		begin
			JSON::parse(self.wizard_json)['action']['name'] + ' "' +
			ActionController::Base.helpers.truncate(URI.unescape(JSON::parse(self.wizard_json)['action']['params'][0]['val']),length:30,omission:'...')+'"'
		rescue
			'undefined'
		end
	end
end
