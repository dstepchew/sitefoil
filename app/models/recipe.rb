# == Schema Information
#
# Table name: recipes
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  status        :string(255)
#  hits          :integer
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  site_id       :integer
#  js            :text
#  wizard_json   :text
#  enabled       :boolean          default(TRUE)
#  hit_last_time :datetime
#

class Recipe < ActiveRecord::Base
	attr_protected []

	has_one :trigger
	has_one :act

	belongs_to :site
	validates :site_id, presence: true

	def name_or_action
		return self['name'] if !self['name'].blank?
		begin
			JSON::parse(self.wizard_json)['action']['name'] + ' "' +
			ActionController::Base.helpers.truncate(URI.unescape(JSON::parse(self.wizard_json)['action']['params'][0]['val']),length:30,omission:'...')+'"'
		rescue
			'undefined'
		end
	end

	def preview_url
		return '' if !(self.site.url rescue false)
		"#{self.site.url}?sitefoil_only_recipe_id=#{self.id}"
	end

	def hit_last_time_human
		return '' if self.hit_last_time.blank?
		(self.hit_last_time.in_time_zone ActiveSupport::TimeZone[self.site.timezone_minutes/60]).to_formatted_s(:rfc822) 
	end
end
