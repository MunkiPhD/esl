$(document).ready(function(){
	$("a.link-to-log-food").click(function(e){
		e.preventDefault();
		console.log("in here!");
		var authToken = Security.GetCSRFToken();
		var foodId = $(this).attr('data-id');
		var postUrl = $(this).attr('data-url');

		var templateHtml = $("#template_log_food").html();
		Mustache.parse(templateHtml);
		var rendered = Mustache.render(templateHtml, { url: postUrl, food_id: foodId, auth: authToken });
		var $rendered = $(rendered);

		SetTodaysDateOnSelects($rendered);

		var $foodDialogDiv = $("#log_food_dialog");
		$foodDialogDiv.html($rendered);

		$foodDialogDiv.dialog({
			resizable: false,
			width: 550,
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
	});
});


function SetTodaysDateOnSelects($container){
		var today = new Date();
		var day = today.getDate();
		var month = today.getMonth() + 1;
		var year = today.getFullYear();

		$container.find("select.select-day").val(day);
		$container.find('select.select-month option[value="' + month + '"]').prop('selected', true);
		$container.find('select.select-year option[value="' + year + '"]').prop('selected', true);

		return false;
}


function LogFood($container){
	console.log("inside LogFood()");
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
		UserMessages.DisplayError("Failed to log the food item.");

	}).always(function(){
		console.log("AJAX post completed");	
	});	

	return false;
}
