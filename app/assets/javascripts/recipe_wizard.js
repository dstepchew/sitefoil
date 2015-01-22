function onTriggerChange() {

	var trigger = $(this).parents(".trigger")
	var trigger_name = trigger.find("#trigger_name").val()
	console.log(trigger_name)
	//removing webshim (polyfill) stuff from template
	$(".trigger_param_template .ws-inputreplace, .trigger_param_template .input-buttons").remove()

	trigger.find("#trigger_param_wrap").htmlPolyfill($(".trigger_param_template[data-trigger-name='"+trigger_name+"']").html()).hide()
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

	adjustRemoveRecipeButtons();

}


function adjustRemoveRecipeButtons() {
	if( $("#recipe_wizard .trigger:last").is("#recipe_wizard .trigger:first") ) {
		$("#recipe_wizard .remove").hide();
	} else {		
		$("#recipe_wizard .remove").show();
	}
}

function onConditionDelete() {
	var trigger = $(this).parents(".trigger")	

	if($("#recipe_wizard .trigger:last").is(trigger) && $("#recipe_wizard .trigger").length>1) {
		$("#recipe_wizard .trigger:last").prev().find("#logic").val("");
		onLogicChange.apply($("#recipe_wizard .trigger:last").prev().find("#logic"));
	} else {
		$(trigger).remove();
	}
	adjustRemoveRecipeButtons();
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


function recipe_save() {
	var recipe = {triggers:[],action:{}}
  $("#recipe_wizard .trigger").each(function() {
     var trigger = {
     	name: $(this).find("#trigger_name").val(),
     	method: $(this).find("#trigger_method").val(),
      param: $(this).find("#trigger_param").val()}
     recipe.triggers.push(trigger)
  })

  recipe.action = {
  	name: $("#action").val(),
  	params: []
  }

  $("#action_params .action_param").each(function() {

   var val;
   if($(this).attr("type")=="checkbox") {
   	val = $(this).is(":checked")
   } else {
   	val = encodeURIComponent($(this).val())
   }
   var param = {name:$(this).attr("name"),val: val}
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

		_.each(recipe.triggers,function(trigger,i) {
			console.log(trigger,i)
			$(".trigger:last #trigger_name").val(trigger.name).trigger("change")
			$(".trigger:last #trigger_method").val(trigger.method).trigger("change")
			$(".trigger:last #trigger_param").val(trigger.param).trigger("change")
			if((i+1)<recipe.triggers.length) {
				$(".trigger:last #logic").val("&&").trigger("change")
			}
		})

		$("#action").val(recipe.action.name).trigger("change")
		_.each(recipe.action.params,function(param) {
			console.log(param)
			var action_param = $("#action_params .action_param[name='"+param.name+"']")
			if(action_param.attr("type")=="checkbox") {
				action_param.attr("checked",param.val)
			} else {
				action_param.val(decodeURIComponent(param.val))
			}
		})
  }
}


$(function() {
  recipe_restore($("#recipe_wizard_json").val())
  adjustRemoveRecipeButtons();

  $("form").submit(function() {
  	$("#recipe_wizard_json").val(recipe_save())
  });

})
