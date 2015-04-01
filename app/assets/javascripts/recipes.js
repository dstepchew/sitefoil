# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(function() {
  $("#recipe_site_id").change(function() {
    return $("#recipe-slide-2").toggle($(this).val() !== "");
  });
  $("input[name=new_site_url]").keyup(function() {
    console.log($(this).val());
    return $("#recipe-slide-2").toggle($(this).val() !== "");
  });
  return $("#recipe_trig_channel_id").change(function() {
    return $("#recipe-slide-3").toggle($(this).val() !== "");
  });
});