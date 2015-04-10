class TestSiteController < ApplicationController
  def index
  	render layout: false
  end

  def main_app
    @use_protocol = "https://"
    @host = "app.sitefoil.com"
    render :index, layout:false
  end
end
