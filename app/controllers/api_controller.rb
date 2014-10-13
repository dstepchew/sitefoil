class ApiController < ApplicationController
  

  def page_selectors_scan
  	require 'open-uri'

  	html = open(params[:url]).read
  	doc = Nokogiri::HTML(html)

  	selectors = []

  	doc.css("input").each do |el|
  		selectors << "#"+el["id"] if el["id"]
  	end


  	render text: selectors.to_json

  end
end
