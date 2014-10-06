window.FoodLog = {};

$(document).ready(function(){
	$("a.link-to-log-food").click(function(e){
		console.log("a.link-to-log-food handler initiated");
		e.preventDefault();
		LogFoodItemHandler(this);
	})
});



window.FoodLog.DeleteFoodLogEntry = function(url, successFunction){
	var result = ""; // this will hold the result message
	var templateId = ""; // this will hold the template ID to use for the selector 

	$.ajax({
		type: "DELETE",
		url: url,
		dataType: "json"
	}).done(function(data, status, xhr){
		console.log(data);
		console.log(status);

		UserMessages.DisplaySuccess("Food log entry deleted.");
		successFunction(); // execute the callback that was passed in with this function

	}).fail(function(xhr, status, error){
		Security.HandleStatusCode(xhr, status, error);

	}).always(function(){
		console.log("done with DELETE request");
	});

	return false;
}



function LogFoodItemHandler(link) {
		var authToken = Security.GetCSRFToken();
		var foodId = $(link).attr('data-id');
		var postUrl = $(link).attr('data-url');

		var templateHtml = $("#template_log_food").html();
		Mustache.parse(templateHtml);
		var rendered = Mustache.render(templateHtml, { url: postUrl, food_id: foodId, auth: authToken });
		var $rendered = $(rendered);

		SetTodaysDateOnSelects($rendered);

		var $foodDialogDiv = $("#log_food_dialog");
		$foodDialogDiv.html($rendered);

		$foodDialogDiv.dialog({
			resizable: false,
			width: 675,
			modal: true,
			buttons: [
				{
					text: "Log Item",
					class: "btn btn-success",
					click: function(){
						$(this).dialog("close");
						LogFood($foodDialogDiv);
						$foodDialogDiv.empty();
					}
				},
				{
					text: "Cancel",
					class: "btn btn-primary",
					click: function(){
						$(this).dialog("close");
						$foodDialogDiv.empty();
					}
				}
			]
		});

		return false;
}


function LogFood($container){
	var $parent = $container.find("form.food-item-log-new");
	var serializedData = $parent.serialize(); // This gets all the data from the form
	var actionUrl = $parent.attr("action");

	$.ajax({
		type: "POST",
		url: actionUrl,
		dataType: "json",
		data: serializedData

	}).done(function(data, status, xhr){
		console.log(data);
		var servings = data["log_food"]["servings"];
		var foodName = data["food_name"];
		var successMessage = servings + " servings of " + foodName + " was logged.";
		UserMessages.DisplaySuccess(successMessage);

	}).fail(function(xhr, status, error){
		Security.HandleStatusCode(xhr, status, error);

	}).always(function(){
		console.log("AJAX post completed");	
	});	

	return false;
}


window.FoodLog.CreateDataForPieChart = function(json){
	// parse the numbers to get them into numerical format //
	var protein = parseFloat(json["daily_totals"].protein);
	var carbs = parseFloat(json["daily_totals"].carbs);
	var fat = parseFloat(json["daily_totals"].total_fat);
	var total = protein + carbs + fat;

	if(total == 0){
		total = 1;
	}
	console.log("Total:" + total);

	/* calculate the percentage for each macronutrient */
	var proteinPercent = (protein / total) * 100;
	var carbPercent = (carbs / total) * 100;
	var fatPercent = (fat / total) * 100;

	var proteinData = {
		start_position: 0,
		end_position: proteinPercent,
		color: "#FFAA00",
		title_text: "Protein",
		amount_grams: protein,
		percent_of_total: proteinPercent
	};
	
	var carbData = {
		start_position: proteinPercent,
		end_position: proteinPercent + carbPercent,
		color: "#FF8800",
		title_text: "Carbs",
		amount_grams: carbs,
		percent_of_total: carbPercent
	};

	var fatData = {
		start_position: proteinPercent + carbPercent,
		end_position: 100,
		color: "#FFEE00",
		title_text: "Fat",
		amount_grams: fat,
		percent_of_total: fatPercent
	};

	var data = [];
	data.push(proteinData);
	data.push(carbData);
	data.push(fatData);

	console.log(data);

	return data;
}
