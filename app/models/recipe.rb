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
	validate :recipe_count_within_limit, :on => :create

	before_save :js_build


	def recipe_count_within_limit
      if self.site.recipes(:reload).count >= 2
      errors.add(:base, "Sorry - you may only create TWO recipes while SiteFoil is in BETA")
    end
  end
	#rebuild all recipes js (needed when recipe generation code is changed)
	#to be called from rails console
	def self.rebuild_all
		self.all.each do |r|
			begin
				r.js = r.js_generate
			rescue Exception => e  
				puts e.message  
				puts e.backtrace.inspect 
				puts "error when generating js for recipe: #{r.id}"
			end
			if r.js_changed?
				puts "js changed for recipe: #{r.id}"
				r.save
			end
		end
		true
	end

	def js_build
		if self.wizard_json_changed?
			self.js = (self.js_generate rescue nil)
			self.js_will_change!
		end
	end

	def js_generate

		wizard_structure = JSON::parse self.wizard_json

		triggers_js = ""
		wizard_structure["triggers"].each do |wizard_trigger|
			trigger = ApplicationHelper::trigger_by_name wizard_trigger["name"]
			if wizard_trigger["method"] && wizard_trigger["method"].include?("?")
				trigger_js = trigger[:js] + wizard_trigger["method"].gsub("?",wizard_trigger["param"])
			else
				trigger_js = trigger[:js] + wizard_trigger["method"]
			end
			triggers_js += " && " if !triggers_js.blank?
			triggers_js += "(#{trigger_js})"
		end

		action_js = ""

		action = ApplicationHelper::action_by_name wizard_structure["action"]["name"]

		action_js = action[:js]
		wizard_structure["action"]["params"].each { |action_param|			
			action_js.gsub! '":'+action_param["name"]+'"', 'decodeURIComponent("'+URI.escape(action_param["val"].to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))+'")'
			action_js.gsub! ":"+action_param["name"], action_param["val"].to_s
		}

		#tracking recipe hit code injection
		action_js = "  sitefoil.report_recipe_hit(recipe_id)\r\n  "+action_js

		"if("+triggers_js+") { \r\n"+action_js+"\r\n}"

	end

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
