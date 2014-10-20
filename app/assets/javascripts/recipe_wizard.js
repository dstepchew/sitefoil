function onConditionChange() {
	var condition = $(this).parents(".condition")
	var condition_name = condition.find("#condition_name").val()
	console.log(condition_name)
	condition.find("#condition_param_wrap").html($(".condition_param_template[data-condition-name='"+condition_name+"']").html()).hide()
	condition.find("#condition_param").val("")
	if(condition_name) {
	  condition.find("#logic").show()		
	  var condition_method_template = $(".condition_methods[data-condition-name='"+condition_name+"']")
		condition.find("#condition_method").show()
		  .html(condition_method_template.html())
		condition.find("#condition_method").attr("data-input-type",condition_method_template.attr("data-input-type"))
	} else {
		condition.find("#condition_method").hide()
	  condition.find("#logic").val("").trigger("change")
	  condition.find("#logic").hide()		
	}

}

function onConditionMethodChange() {
	var condition = $(this).parents(".condition")	
	var condition_method = condition.find("#condition_method").val()
	if(condition_method && _.str.contains(condition_method,"?")) {
		condition.find("#condition_param_wrap").show().find("#condition_param").val("")
	} else {
		condition.find("#condition_param_wrap").hide()
	}
}

function onLogicChange() {
	var condition = $(this).parents(".condition")	
	var logic = condition.find("#logic").val()
	if(logic) {
		if(!condition.next().hasClass("condition")) {
			condition.after($("#condition_template").html())
		}
	} else {
		//remove all later conditions
		var remove = false;
		$("#conditions .condition").each(function() {
			if(remove) {
				$(this).remove()
			}
			if(condition.is(this)) {
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
	var condition_js = ""

	$("#conditions .condition").each(function() {
		var condition_name = $(this).find("#condition_name").val()
		console.log(condition_name)
		var condition_name_js = $(this).find("#condition_name option[value='"+condition_name+"']").attr('data-js')
		console.log(condition_name_js)
		var method_js = $(this).find("#condition_method").val()
		console.log("method_js",method_js)
		var value_js = $(this).find("#condition_param").val()

		var this_condition_js;


		if(method_js && _.str.contains(method_js,"?")) {
	    this_condition_js = condition_name_js+method_js.replace("?",value_js)
		} else {
			this_condition_js = condition_name_js+method_js
		}

		condition_js = condition_js + "("+this_condition_js+") "

		var logic = $(this).find("#logic").val()
		if(logic) {
			condition_js = condition_js + " "+logic+" "
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
  	action_js = action_js.replace('":'+name+'"', "decodeURIComponent('"+encodeURIComponent(val)+"')")
  	action_js = action_js.replace(':'+name, val)
  })

	js = "if("+condition_js+") { "+action_js+" }";

	$("#recipe_js").val(js)

	$("#recipe_wizard_json").val(recipe_save)

}

function recipe_save() {
	var recipe = {conditions:[],action:{}}
  $("#recipe_wizard .condition").each(function() {
     var condition = {
     	name: $(this).find("#condition_name").val(),
     	method: $(this).find("#condition_method").val(),
      param: $(this).find("#condition_param").val(),
      logic: $(this).find("#logic").val()}
     recipe.conditions.push(condition)
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

	$("#conditions").append($("#condition_template").html())
	if(json) {
		try {
		  var recipe = JSON.parse(json)
	  } catch(err) {
	  	alert("bad recipe data")
	  	return;
	  }
		_.each(recipe.conditions,function(condition) {
			$(".condition").last().find("#condition_name").val(condition.name).trigger("change")
			$(".condition").last().find("#condition_method").val(condition.method).trigger("change")
			$(".condition").last().find("#condition_param").val(condition.param).trigger("change")
			$(".condition").last().find("#logic").val(condition.logic).trigger("change")
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
})
