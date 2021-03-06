function onTriggerChange() {
	var trigger = $(this).parents(".trigger")
	var trigger_name = trigger.find("#trigger_name").val()
	console.log(trigger_name)
	trigger.find("#trigger_param_wrap").html($(".trigger_param_template[data-trigger-name='"+trigger_name+"']").html()).hide()
	trigger.find("#trigger_param").val("")
	if(trigger_name) {
	  trigger.find("#logic").show()		
	  var trigger_method_template = $(".trigger_methods[data-trigger-name='"+trigger_name+"']")
		trigger.find("#trigger_method").show()
		  .html(trigger_method_template.html())
		trigger.find("#trigger_method").attr("data-input-type",trigger_method_template.attr("data-input-type"))
	} else {
		trigger.find("#trigger_method").hide()
	  trigger.find("#logic").val("").trigger("change")
	  trigger.find("#logic").hide()		
	}

}

function onTriggerMethodChange() {
	var trigger = $(this).parents(".trigger")	
	var trigger_method = trigger.find("#trigger_method").val()
	if(trigger_method && _.str.contains(trigger_method,"?")) {
		trigger.find("#trigger_param_wrap").show().find("#trigger_param").val("")
	} else {
		trigger.find("#trigger_param_wrap").hide()
	}
}

function onLogicChange() {
	var trigger = $(this).parents(".trigger")	
	var logic = trigger.find("#logic").val()
	if(logic) {
		if(!trigger.next().hasClass("trigger")) {
			trigger.after($("#trigger_template").html())
		}
	} else {
		//remove all later triggers
		var remove = false;
		$("#triggers .trigger").each(function() {
			if(remove) {
				$(this).remove()
			}
			if(trigger.is(this)) {
				console.log('removing')
				remove = true;
			}
		})
	}

}

function onActionChange() {
	var action = $("#action").val()
	if(action) {
		$("#action_params").show()
		  .html($(".action_params[data-action-name='"+action+"']").html())
	} else {
		$("#action_params").hide()
	}
}

function buildRecipe() {
	console.log("build recipe")
	var js = "";
	var trigger_js = ""

	$("#triggers .trigger").each(function() {
		var trigger_name = $(this).find("#trigger_name").val()
		console.log(trigger_name)
		var trigger_name_js = $(this).find("#trigger_name option[value='"+trigger_name+"']").attr('data-js')
		console.log(trigger_name_js)
		var method_js = $(this).find("#trigger_method").val()
		console.log("method_js",method_js)
		var value_js = $(this).find("#trigger_param").val()

		var this_trigger_js;


		if(method_js && _.str.contains(method_js,"?")) {
	    this_trigger_js = trigger_name_js+method_js.replace("?",value_js)
		} else {
			this_trigger_js = trigger_name_js+method_js
		}

		trigger_js = trigger_js + "("+this_trigger_js+") "

		var logic = $(this).find("#logic").val()
		if(logic) {
			trigger_js = trigger_js + " "+logic+" "
		}
  })

  var action_js;

  var action_name = $("#action").val()
  console.log("action name", action_name)
  var action_js = $("#action option[value='"+action_name+"']").attr("data-js")

  $("#action_params input, #action_params textarea").each(function() {
  	var name = $(this).attr("name")
  	var val = $(this).val()
  	console.log("action_param input: ", name, val)
  	action_js = action_js.replace('":'+name+'"', 'decodeURIComponent("'+encodeURIComponent(val)+'")')
  	action_js = action_js.replace(':'+name, val)

  	action_js = "sitefoil.report_recipe_hit("+RECIPE_ID+")\n"+action_js
  })

	js = "if("+trigger_js+") { "+action_js+" }";

	$("#recipe_js").val(js)

	$("#recipe_wizard_json").val(recipe_save)

}

function recipe_save() {
	var recipe = {triggers:[],action:{}}
  $("#recipe_wizard .trigger").each(function() {
     var trigger = {
     	name: $(this).find("#trigger_name").val(),
     	method: $(this).find("#trigger_method").val(),
      param: $(this).find("#trigger_param").val(),
      logic: $(this).find("#logic").val()}
     recipe.triggers.push(trigger)
  })

  recipe.action = {
  	name: $("#action").val(),
  	params: []
  }

  $("#action_params .action_param").each(function() {
   var param = {name:$(this).attr("name"),val: encodeURIComponent($(this).val())}
   recipe.action.params.push(param)
  })

  return JSON.stringify(recipe)

}

function recipe_restore(json) {

	$("#triggers").append($("#trigger_template").html())
	if(json) {
		try {
		  var recipe = JSON.parse(json)

		  recipe.triggers = recipe.triggers || recipe.conditions

	  } catch(err) {
	  	alert("bad recipe data")
	  	return;
	  }
		_.each(recipe.triggers,function(trigger) {
			$(".trigger").last().find("#trigger_name").val(trigger.name).trigger("change")
			$(".trigger").last().find("#trigger_method").val(trigger.method).trigger("change")
			$(".trigger").last().find("#trigger_param").val(trigger.param).trigger("change")
			$(".trigger").last().find("#logic").val(trigger.logic).trigger("change")
		})

		$("#action").val(recipe.action.name).trigger("change")
		_.each(recipe.action.params,function(param) {
			$("#action_params .action_param[name='"+param.name+"']").val(decodeURIComponent(param.val))
		})
  }
}


function js_show() {
	$("#recipe_js").parents(".form-group").show()
}
$(function() {
  recipe_restore($("#recipe_wizard_json").val())

  $("body").on("change","select, .action_param",buildRecipe)
  $("body").on("keyup change","input, .action_param",buildRecipe)
  $("body").on("submit","form",buildRecipe)
})
