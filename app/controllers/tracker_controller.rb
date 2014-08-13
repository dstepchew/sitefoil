class TrackerController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token
  before_action :set_headers

  #tracker.js script is fetched with this method
  def index

     @site = Site.find params[:site_id]

     if cookies[:track_id]
       Rails.logger.info "returning visitor"
       visitor = Visitor.find_by_id cookies[:track_id]
     end
     if !visitor
       Rails.logger.info "new visitor"
       visitor = Visitor.create
       cookies[:track_id] = { :value => visitor.id, :expires => 30.days.from_now }      
     end
     @hit = visitor.hits.create ip: request.remote_ip, 
       browser: request.env['HTTP_USER_AGENT']
     render "index", :content_type => "application/javascript"
  end

  #script itself will post data to this method
  def data_from_script

     if params.has_key? :hit_id
       hit = Hit.find(params[:hit_id])
       hit.update_attributes referrer: params[:hit][:referrer]
     end
     render text:"data from script for hit id: #{params[:hit_id]} posted"
  end

  private
  def set_headers
     response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
     response.headers["Pragma"] = "no-cache"
     response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
     response.headers['Access-Control-Allow-Origin'] = '*'
     response.headers['Access-Control-Request-Method'] = '*'
  end
end
