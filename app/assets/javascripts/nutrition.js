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


	// generate the pie chart of daily totals
	RefreshDailyTotalsPieChart();
});


function RefreshDailyTotalsPieChart(){
	/* get the json data from the api call */
	try {
		var currentDate = $("#selected_date_value").value; 
		console.log("date: " + currentDate);

		var jsonData = { "protein": 40, "carbs": 30, "fat": 30, "date":"14-April-2014" };	
		var data = FoodLog.CreateDataForPieChart(jsonData);
		console.log("data:");
		console.log(data);

		CreatePieChart(data);
	}catch(e){
		console.log(e);
	}
	//	totals_pie_chart_svg
}

function CreatePieChart(data){
	var svgId = "#totals_pie_chart_svg";
	var canvasWidth = $(svgId).attr("width");
	var canvasHeight = $(svgId).attr("height");

	var myScale = d3.scale.linear().domain([0,100]).range([0, 2 * Math.PI]);
	var vis = d3.select("#totals_pie_chart_svg");
	var arc = d3.svg.arc()
	.innerRadius(50)
	.outerRadius(100)
	.startAngle(function(d){
		return myScale(d.start_position);
	})
	.endAngle(function(d){
		return myScale(d.end_position);
	});

	var translate = "translate(" + (canvasWidth / 2) + "," + (canvasHeight / 2) + ")";
	console.log(translate);

	/*
	var div = d3.select("body").append("div")
	.attr("class", "tooltip")
	.style("opacity", 0);
  */

	vis.selectAll("path")
	.data(data)
	.enter()
	.append("path")
	.attr("d", arc)
	.style("fill", function(d){
		return d.color;
	})
	.attr("transform", translate);

	/*
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
  */
}
