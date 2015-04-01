# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.testSite = function(site_id) {
  $("body").prepend('<div style="position:fixed;width:100%;height:100%;left:0px;top:0px;background:#000;opacity:0.2;z-index:10000;cursor:wait;" id="testsite_wait"></div>');
  return $.get("/api/test_site", {
    site_id: site_id
  }, function(resp) {
    $("#testsite_wait").remove();
    resp = JSON.parse(resp);
    return $("#site_test_script_installed").html(resp.script_installed);
  });
};