# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.testSite = (site_id) ->
	$.get "/dashboard/test_site",{site_id:site_id}, (resp) ->
		resp = JSON.parse(resp)
		$("#site_test_script_installed").html(resp.script_installed)
		$("#site_test_coupon_field").html(resp.coupon_field)
