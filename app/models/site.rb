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


  def test_script_installed
  	require 'open-uri'
  	url = self.url
  	if !url.starts_with? "http"
  		url = "http://#{url}"
  	end
  	Rails.logger.info("reading: #{url}")
    begin
  	  html = open(url).read
    rescue
      return "can't open #{url}"
    end

    Rails.logger.info("html: #{html.length} bytes")
  	doc = Nokogiri::HTML(html)
  	Rails.logger.info("looking for: "+self.tracker_url($HOST_WITH_PORT))
  	doc.search("script").each do |script|
  		Rails.logger.info(script.attr("src").to_s)
  		if script.attr("src").to_s == self.tracker_url($HOST_WITH_PORT)
  			return "script installed"
  		end
  	end
  	return "link to tracking script not found"
  end

  def tracker_url host_with_port
    "http://#{host_with_port}/tracker.js"
  end

end
