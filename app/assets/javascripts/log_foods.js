window.FoodLog = {};

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

		result = "Food log entry deleted.";
		templateId = "#template_alert_success";
		successFunction();

	}).fail(function(xhr, status, error){
		console.log(status);
		console.log(error);

		result = "An error occured while attempting to delete the entry.";
		templateId = "#template_alert_error";

	}).always(function(){
		var templateHtml = $(templateId).html();
		Mustache.parse(templateHtml);
		var rendered = Mustache.render(templateHtml, { message: result });
		$("#flash_messages").append(rendered);
		console.log("done with DELETE request");
	});

	return false;
}
