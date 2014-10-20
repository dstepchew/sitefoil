class ApiController < ApplicationController
  

  def page_selectors_scan
    sleep 1.5
  	require 'open-uri'
    ret = {selectors:[],error_message:nil}

    begin
  	   html = open(params[:url]).read
    rescue
      ret[:error_message] = 'error while opening/reading url'
      render text: ret.to_json
      return
    end
  	doc = Nokogiri::HTML(html)

  	doc.css("*").each do |el|
  		ret[:selectors] << "#"+el["id"] if el["id"]
  	end


  	render text: ret.to_json

  end
end
