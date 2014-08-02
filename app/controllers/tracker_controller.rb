class TrackerController < ApplicationController
	layout false
  def index
     response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
     response.headers["Pragma"] = "no-cache"
     response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  	 render "index", :content_type => "application/javascript"

     if !cookies[:track_id]
     	Rails.logger.info "new visitor"
     	visitor = Visitor.create
     	cookies[:track_id] = { :value => visitor.id, :expires => 30.days.from_now }
     else
     	Rails.logger.info "returning visitor"
     	visitor = Visitor.find_by_id cookies[:track_id]
     end

     visitor.hits.create ip: request.remote_ip, browser: request.env['HTTP_USER_AGENT']
  end
end
