class DashboardController < ApplicationController
	def test_site
		$HOST_WITH_PORT = request.host_with_port
		site = current_user.sites.find(params[:site_id])
		render text:{
			   script_installed: site.test_script_installed,
			   coupon_field: site.test_coupon_field

			   }.to_json
	end

end
