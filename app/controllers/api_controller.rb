class ApiController < ApplicationController


  def recipe_create
    if params[:recipe_json]


      if !current_user && params[:user]
        user = User.new JSON::parse(params[:user])
        if !user.save
          render text: {error: user.errors.full_messages}.to_json
          return
        end
      else
        user = current_user
      end

      if params[:site]
        site = user.sites.create JSON::parse(params[:site])
      else
        site = user.sites.find_by_id recipe_attr["site_id"]
      end
      

      recipe_attr = JSON::parse params[:recipe_json]
      recipe = site.recipes.new(recipe_attr)

      if recipe.save
        render text: {message: "recipe created #{recipe.id}"}.to_json
      else 
        render text: {error: "recipe not created, error while saving recipe #{@recipe.errors}"}.to_json
      end

    end    
  end

  def test_site
    site = current_user.sites.find(params[:site_id])
    render text:{
      script_installed: site.test_script_installed(host: request.host_with_port)
    }.to_json
  end

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

  def report_recipe_hit

    recipe = Recipe.find(params[:id])
    recipe.hits = recipe.hits.to_i + 1
    recipe.hit_last_time = Time.now
    recipe.save

    render nothing: true

  end

  before_action :set_headers
  private
  def set_headers
     response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
     response.headers["Pragma"] = "no-cache"
     response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
     response.headers['Access-Control-Allow-Origin'] = '*'
     response.headers['Access-Control-Request-Method'] = '*'
  end

end
