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
#  coupon_selector  :string(255)
#  status           :string(255)
#  checkout_url     :string(255)
#  total_selector   :string(255)
#  confirmation_url :string(255)
#  tag              :text
#

class Site < ActiveRecord::Base

  attr_protected []

	validates_presence_of :user_id, :name, :url
  	 
	belongs_to :user
	has_many :recipes
	has_many :channels
  serialize :tag, Hash


  def test_script_installed
  	require 'open-uri'
  	url = Site::fix_url self.url
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

  def test_coupon_field
    require 'open-uri'

    begin
      html = open(Site::fix_url self.coupon_url).read 
    rescue 
      return "can't open coupon url #{self.coupon_url}"
    end

    return "coupon element not found" if !Site::selector_exists html, self.coupon_selector 

    "selector found"

  end

  def tracker_url host_with_port
    "http://#{host_with_port}/tracker.js?site_id=#{self.id}"
  end

  def self.selector_exists html, selector
    doc = Nokogiri::HTML(html)
    doc.search(Site::fix_selector selector).length>0
  end

  def self.fix_selector selector
    if (selector.include? "#") || (selector.include? ".")
      selector
    else
      "##{selector}"
    end
  end

  def self.fix_url url
    if url.starts_with? "http"
      url 
    else
      "http://#{url}"
    end
  end


  def recipe_if_referrer_then_set_value referrer, field_selector, value
    "console.log('document.referrer: '+document.referrer) \n"+
    "if(document.referrer==\"#{referrer}\") { \n"+
    "  document.querySelector(\"#{field_selector}\").value=\"#{value}\" \n"+
    "} \n"

  end
end
