class TrackerController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_headers

  #tracker.js script is fetched with this method

  def test
    @geoip ||= GeoIP.new(GEOIP_DATA)

    data = @geoip.country(request.remote_ip)
    render text: data.to_json
  end

  def index

    if !params[:site_id]
      render text:"site_id parameter not specified", status: 400
      return
    end

    @site = Site.find_by_id params[:site_id]

    if !@site
     render text: "site with such id not found", status: 400
     return
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
    @hit.url = request.referrer #url that calls script


    @geoip ||= GeoIP.new(GEOIP_DATA)

    data = @geoip.country(request.remote_ip)
    if data
      @hit.tag[:location] = data
      @hit.country = data.country_name
      @hit.state = data.real_region_name
      @hit.city = data.city_name
    end

    @hit.tag[:user_agent] = request.user_agent
    @hit.device = user_agent_to_device request.user_agent
    @hit.os_name = user_agent_to_os_name request.user_agent
    @hit.site = @site
    @hit.new_visitor = new_visitor
    @hit.ip = request.remote_ip
    @hit.browser = request.user_agent
    @hit.save

    if params[:no_site_stats]
      @site_hash = {
        timezone_string: @site.timezone_string
      }
    else
      @site_hash = {order_count: @site.orders_count, 
        conversion_rate: @site.conversion_rate, 
        conversion_rate_24_hours: @site.conversion_rate_24_hours,
        timezone_string: @site.timezone_string}
    end

    @app_base = APP_PROTOCOL+request.host_with_port

    if params[:format] == "html"
        render :profiling
    else
        js = index_render
        render text: js, layout: false, content_type: "application/javascript"
    end

  end

  def index_render
     js = render_to_string "index_static"
     js += render_to_string "index"
     js    
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
       hit.update_attributes referrer: params[:hit][:referrer]
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
