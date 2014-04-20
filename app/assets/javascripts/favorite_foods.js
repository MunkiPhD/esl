$(document).ready(function(){
	$("#favorite_foods_list .control-panel a").click(function(e){
		e.preventDefault();
		var authToken = Security.GetCSRFToken();
		var foodId = $(this).attr('data-id');
		var postUrl = $(this).attr('data-url');
		console.log(authToken);

		var templateHtml = $("#template_log_food").html();
		Mustache.parse(templateHtml);
		var rendered = Mustache.render(templateHtml, { url: postUrl, food_id: foodId, auth: authToken });
		$("#favorite_foods_list").append(rendered);

		return false;
	});
});

$(document).on("click", "form.food-item-log-new a.btn-submit", function(e){
	e.preventDefault();

	// perform ajax submit
	var $parent = $(this).parents("form.food-item-log-new");
	var serializedData = $parent.serialize(); // This gets all the data from the form

	console.log(serializedData);

	$parent.slideUp(400, function(e){
		$(this).remove();
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
