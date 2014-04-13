$(document).ready(function(){
	$(".logged-food-entry a[data-method='DELETE']").on("click", function(event){
		var $theEntry = $(this);
		var dataMessage = $theEntry.attr('data-confirm');

		// make sure there is a data-confirmation. If no confirmation on a delete, don't do anything
		if(dataMessage != undefined){
			if(confirm(dataMessage) == false){ // if the user opts to cancel, do nothing
				return false;
			}
		} else {
			console.log("No confirmation message is defined. Skipping...");
			return false;
		}

		var url = $theEntry.attr('href');

		// use a lambda expression to handle the success event
		FoodLog.DeleteFoodLogEntry(url, function(){
			$theEntry.parents(".logged-food-entry").slideUp('slow', function(){
				// animation complete															  
				// eventually issue an update to the screen for modified data
			});
		});

		return false;
	});
});

