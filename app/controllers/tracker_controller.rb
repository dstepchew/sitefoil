class TrackerController < ApplicationController
  layout false
  skip_before_action :verify_authenticity_token
  before_action :set_headers

  #tracker.js script is fetched with this method
  def index

     if !params[:site_id]
        throw "site_id parameter not specified"
     end
 
     @site = Site.find_by_id params[:site_id]

     if !@site
       throw "site with such id not found"
     end

     new_visitor = false
     if cookies[:track_id]
       visitor = Visitor.find_by_id cookies[:track_id]
     end

     if !visitor
       visitor = Visitor.create
       cookies[:track_id] = { :value => visitor.id, :expires => 100.years.from_now }      
       new_visitor = true
     end
     @hit = visitor.hits.new
     #saving whole data just in case
     @hit.referrer = request.referrer
     @hit.tag[:location] = request.location.data
     @hit.tag[:user_agent] = request.user_agent
     @hit.device = user_agent_to_device request.user_agent
     @hit.os_name = user_agent_to_os_name request.user_agent
     @hit.site = @site
     @hit.new_visitor = new_visitor
     @hit.ip = request.remote_ip
     @hit.country = request.location.data["country_name"]
     @hit.state = request.location.data["region_name"]
     @hit.city = request.location.data["city"]
     @hit.browser = request.user_agent
     @hit.save
     render "index", :content_type => "application/javascript"
  end

  def user_agent_to_os_name user_agent
    return "Android" if user_agent.downcase =~/android/
    return "Windows" if user_agent =~/Win/
    return "MacOS"   if user_agent =~ /Mac/
    return "Linux"   if user_agent =~ /Linux/
    return "UNIX"    if user_agent =~/X11/
    'unknown'
  end

  def user_agent_to_device user_agent
     if user_agent =~ /Android/
        if user_agent =~ /Mobile/
          return 'phone'
        else
          return 'tablet'
        end
     end

     return 'phone' if user_agent =~ /(iPhone|iPod)/
     return 'tablet' if user_agent =~ /iPad/

     return 'desktop'
  end

  #script itself will post data to this method
  def data_from_script

     if params.has_key? :hit_id
       hit = Hit.find(params[:hit_id])
       #hit.update_attributes referrer: params[:hit][:referrer]
     end
     render text:"data from script for hit id: #{params[:hit_id]} posted"
  end

  def email_action
    (Mailer::email_action subject: "sitefoil notification", text: params[:text], to_email:params[:to_email]).deliver
    render nothing: true
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
