class SitesController < ApplicationController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @sites = Site.all
  end

  def show
  end

  def new
    @site = current_user.sites.build
  end

  def edit
  end

  def create
     @site = current_user.sites.build(site_params)
    if @site.save
      redirect_to @site, notice: 'Site was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @site.update(site_params)
      redirect_to @site, notice: 'Site was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @site.destroy
    redirect_to sites_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

     def correct_user
      @site = current_user.sites.find_by(id: params[:id])
      redirect_to sites_path, notice: "Not authorized to edit this site" if @site.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_params
      params.require(:site).permit(:name,:url,:coupon_url)
    end
end