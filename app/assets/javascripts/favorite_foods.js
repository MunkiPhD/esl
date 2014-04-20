$(document).ready(function(){
	$("#favorite_foods_list .control-panel a").click(function(e){
		e.preventDefault();
		var authToken = Security.GetCSRFToken();
		var foodId = $(this).attr('data-id');
		var postUrl = $(this).attr('data-url');
		var foodName = $(this).attr('data-food-name');

		var templateHtml = $("#template_log_food").html();
		Mustache.parse(templateHtml);
		var rendered = Mustache.render(templateHtml, { url: postUrl, food_id: foodId, auth: authToken, food_name: foodName });
		var $parent = $(this).parents(".favorite-food-item");
		$(rendered).hide().insertAfter($parent).slideDown();

		return false;
	});
});



$(document).on("click", "form.food-item-log-new a.btn-submit", function(e){
	e.preventDefault();

	var $parent = $(this).parents("form.food-item-log-new");
	var serializedData = $parent.serialize(); // This gets all the data from the form
	var actionUrl = $parent.attr("action");
	var foodName = $parent.attr("data-food-name");

	// perform ajax submit
	$.ajax({
		type: "POST",
		url: actionUrl,
		dataType: "json",
		data: serializedData

	}).done(function(data, status, xhr){
		console.log(data);
		var successMessage = data["log_food"]["servings"] + " servings of " + foodName + " was logged.";
		UserMessages.DisplaySuccess(successMessage);

	}).fail(function(xhr, status, error){
		UserMessages.DisplayError("Failed to log the food item.");

	}).always(function(){
		console.log("AJAX post completed");	
		$parent.slideUp(400, function(e){
			$(this).remove();
		});
	});	

	return false;
});



/*
 * Adds an event handler to the cancel button for logging a food item
 */
$(document).on("click", "form.food-item-log-new a.btn-cancel", function(e){
	e.preventDefault();
	var $parent = $(this).parents("form.food-item-log-new");
	$parent.slideUp(400, function(e){
		$(this).remove();
	});

	return false;
});

