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
#

class Site < ActiveRecord::Base

  attr_protected []

	validates_presence_of :user_id, :url
  	 
	belongs_to :user
	has_many :recipes
  has_many :hits, dependent: :destroy
	has_many :channels
  serialize :tag, Hash


  def order_count
    self.hits.where(referrer: self.order_url).count
  end

  def unique_visitors_count
    self.hits.group(:visitor).count.count
  end

  def unique_visitors_made_order_count
    self.hits.where(referrer: self.order_url).group(:visitor).count.count
  end

  def conversion_rate
    100 * self.unique_visitors_made_order_count.to_f / self.unique_visitors_count.to_f
  end

  def test_script_installed opt
  	require 'open-uri'
  	url = Site::fix_url self.url
  	Rails.logger.info("reading: #{url}")
    begin
  	  html = open(url,"r",read_timeout: 4).read 
    rescue Exception=>e
      return "<span class=error>error: can't open #{url}. #{e.message}</span>"
    end

    Rails.logger.info("html: #{html.length} bytes")
  	doc = Nokogiri::HTML(html)
  	Rails.logger.info("looking for: "+self.tracker_url(opt[:host]))
  	doc.search("script").each do |script|
  		Rails.logger.info(script.attr("src").to_s)
  		if script.attr("src").to_s == self.tracker_url(opt[:host])
  			return "<span class=success>script installed<span>"
  		end
  	end
  	return "<span class=error>link to tracking script not found</span>"
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

  def name_or_url
    return self.url if self.name.blank? 
    self.name
  end

end
