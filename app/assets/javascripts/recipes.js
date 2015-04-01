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