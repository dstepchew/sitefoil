# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	$("#recipe_site_id").change ->
		$("#recipe-slide-2").toggle($(this).val()!="")

	$("input[name=new_site_url]").keyup ->
		console.log($(this).val())
		$("#recipe-slide-2").toggle($(this).val()!="")

	$("#recipe_trig_channel_id").change ->
		$("#recipe-slide-3").toggle($(this).val()!="")
