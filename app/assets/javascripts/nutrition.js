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
			$theEntry.parents(".logged-food-entry").fadeOut('slow', function(){
				//* animation complete*/
				RefreshDailyTotalsPieChart() // refresh the daily totals
			});
		});

		return false;
	});

});


//
// Refreshes the pie chart that displays the daily totals of macronutrient intake
//
function RefreshDailyTotalsPieChart(){
	/* get the json data from the api call */
	try {
		var currentDate = $("#selected_date_value").val(); 
		console.log("date: " + currentDate);

		$.ajax({
			type: "GET",
			data: { date: currentDate },
			dataType: "json",
			url: 'api/nutrition/log/daily_totals'
		}).done(function(data, status, xhr){
			console.log(data);
			var jsonData = FoodLog.CreateDataForPieChart(data);
			console.log("data:");
			console.log(jsonData);

			$("#daily_totals_chart").empty();
			CreatePieChart(jsonData, "#daily_totals_chart");

		}).fail(function(xhr, status, error){
			console.log(e);
		}).always(function(){
			// do nothing
		});
	}catch(e){
		console.log(e);
	}
}


//
// Creates the pie chart from the data
//
function CreatePieChart(data, id){
	var vis = d3.select(id);
	var visSVG = vis.append("svg");

	var width = 310;
	var height = 200;
	visSVG.attr("height", height)
	.attr("width", width);


	var linearScale = d3.scale.linear().domain([0,100]).range([0, Math.PI *2]);
	var arc = d3.svg.arc()
	.innerRadius(50)
	.outerRadius(function(d){
		return 100; //d.start_position * 10;						
	})
	.startAngle(function(d){
		return linearScale(d.start_position);
	})
	.endAngle(function(d){
		return linearScale(d.end_position);				 
	});

	var div = d3.select("body").append("div")
	.attr("class", "tooltip")
	.style("opacity", 0);


	visSVG.selectAll("path")
	.data(data)
	.enter()
	.append("path")
	.attr("d", arc)
	.style("fill", function(d){
		return d.color;
	})
	.attr("transform", function(d){
		var xLoc = width / 2;
		var yLoc = height / 2;
		var translateStr = "translate(" + xLoc + "," + yLoc + ")";
		return translateStr;
	})
	.on("mouseover", function(d) {
		div.transition()
		.duration(200)
		.style("opacity", .9);
		div.html((d.title_text) + "<br/>" + d.percent_of_total.toFixed(1) + "%")
		.style("left", (d3.event.pageX)  + "px")
		.style("top", (d3.event.pageY - 28) + "px");
	})
	.on("mouseout", function(d){
		div.transition()
		.duration(500)
		.style("opacity", 0);
	})
}
