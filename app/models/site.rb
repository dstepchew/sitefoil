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
#  status           :string(255)
#  checkout_url     :string(255)
#  total_selector   :string(255)
#  confirmation_url :string(255)
#  tag              :text
#  order_url        :string(255)
#  timezone_minutes :integer          default(0)
#

class Site < ActiveRecord::Base

  attr_protected []

	validates_presence_of :user_id, :url
  	 
	belongs_to :user
	has_many :recipes
  has_many :hits, dependent: :destroy
	has_many :channels
  serialize :tag, Hash


  def order_url_sql_wildcard
    if self.order_url.blank?
      return ""
    else
      self.order_url.gsub("*","%") + "%"
    end
  end

  def orders
    self.hits.where("url like ?",self.order_url_sql_wildcard)
  end

  def unique_visitor_hits
    self.hits.group(:visitor)
  end

  def unique_visitors_orders
    self.hits.where("url like ?",self.order_url_sql_wildcard).group(:visitor)
  end

  def conversion_rate
    return 0 if (self.unique_visitor_hits.count.count==0 rescue true)
    100 * self.unique_visitors_orders.count.count.to_f / self.unique_visitor_hits.count.count.to_f
  end

  def conversion_rate_24_hours
    100.0 * self.unique_visitors_orders.where("created_at>?",24.hours.ago).count.count.to_f / self.unique_visitor_hits.where("created_at>?",24.hours.ago).count.count.to_f
  end

  def test_script_installed opt
  	require 'open-uri'
  	url = Site::fix_url self.url
  	Rails.logger.info("reading: #{url}")
    begin
  	  html = open(url,"r",read_timeout: 4).read 
    rescue Exception=>e
      return "<span class=error>Error: We can't open #{url}. #{e.message}</span>"
    end

    Rails.logger.info("html: #{html.length} bytes")
  	doc = Nokogiri::HTML(html)
  	Rails.logger.info("looking for: "+self.tracker_url(opt[:host]))
  	doc.search("script").each do |script|
  		Rails.logger.info(script.attr("src").to_s)
  		if script.attr("src").to_s == self.tracker_url(opt[:host])
  			return "<span class=success>Good job! Your code is installed<span>"
  		end
  	end
  	return "<span class=error>Oops! We can't find your tracking code. <br />Please make sure you have installed it correctly and try again.</span>"
  end

  def tracker_url host_with_port
    "https://#{host_with_port}/tracker.js?site_id=#{self.id}"
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

  def name_or_url
    return self.url if self.name.blank? 
    self.name
  end

  def timezone_string
    format("%+03d%02d", self.timezone_minutes/60,self.timezone_minutes%60)
  end

  def time
     Time.now.in_time_zone ActiveSupport::TimeZone[self.timezone_minutes/60]
  end

end