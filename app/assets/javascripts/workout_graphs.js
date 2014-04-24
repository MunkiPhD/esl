var WorkoutGraphs = window.WorkoutGraphs || {};

WorkoutGraphs.DualYAxisGraph = function(argsObj){
	var data1 = argsObj.y1Data;
	var data2 = argsObj.y2Data;
	var y1Title = argsObj.y1Title;
	var y2Title = argsObj.y2Title;
	var xTitle = argsObj.xTitle;
	
	//var data1 = [10,5,5,5,5,4,4,2,2,10];
	//var data2 = [45,135,135,185,225,315,315,335,385,225];

	var margin = [80,80,80,80];
	var width = 500 - margin[1] - margin[3];
	var height = 400 - margin[0] - margin[2];

	var y1Max = d3.max(data1, function(d){ return +d; });
	var y2Max = d3.max(data2, function(d){ return +d; });

	// X scale will fit all values from data[] within pixels 0-w
	var x = d3.scale.linear().domain([1, data1.length]).range([0, width]);
	// Y scale will fit values from 0-10 within pixels h-0 (Note the inverted domain for the y-scale: bigger is up!)
	var y1 = d3.scale.linear().domain([0, (1.1 * y1Max)]).range([height, 0]); // in real world the domain would be dynamically calculated from the data
	var y2 = d3.scale.linear().domain([0, (1.1 * y2Max) ]).range([height, 0]); // in real world the domain would be dynamically calculated from the data
	// automatically determining max range can work something like this
	// var y = d3.scale.linear().domain([0, d3.max(data)]).range([h, 0]);

	// create a line function that can convert data[] into x and y points
	var line1 = d3.svg.line()
	// assign the X function to plot our line as we wish
	.x(function (d, i) {
	    // return the X coordinate where we want to plot this datapoint
	    return x(i+1);
	})
	    .y(function (d) {
	    // return the Y coordinate where we want to plot this datapoint
	    return y1(d);
	})
	// create a line function that can convert data[] into x and y points
	var line2 = d3.svg.line()
	// assign the X function to plot our line as we wish
	.x(function (d, i) {
	    // return the X coordinate where we want to plot this datapoint
	    return x(i+1);
	})
	    .y(function (d) {
	    // verbose logging to show what's actually being done
	    return y2(d);
	})


	// Add an SVG element with the desired dimensions and margin.
	var graph = d3.select("#graph").append("svg:svg")
	    .attr("width", width + margin[1] + margin[3])
	    .attr("height", height + margin[0] + margin[2])
	    .append("svg:g")
	    .attr("transform", "translate(" + margin[3] + "," + margin[0] + ")");

	// create yAxis
	var xAxis = d3.svg.axis().scale(x).tickSize(-height).tickSubdivide(true);
	// Add the x-axis.
	graph.append("svg:g")
	    .attr("class", "x axis")
	    .attr("transform", "translate(0," + height + ")")
	    .call(xAxis);


	// create left yAxis
	var yAxisLeft = d3.svg.axis().scale(y1).ticks(4).orient("left");
	// Add the y-axis to the left
	graph.append("svg:g")
	    .attr("class", "y axis axisLeft")
	    .attr("transform", "translate(-15,0)")
	    .call(yAxisLeft);

	// create right yAxis
	var yAxisRight = d3.svg.axis().scale(y2).ticks(6).orient("right");
	// Add the y-axis to the right
	graph.append("svg:g")
	    .attr("class", "y axis axisRight")
	    .attr("transform", "translate(" + (width + 15) + ",0)")
	    .call(yAxisRight);
	// add lines
	// do this AFTER the axes above so that the line is above the tick-lines
	graph.append("svg:path").attr("d", line1(data1)).attr("class", "data1");
	graph.append("svg:path").attr("d", line2(data2)).attr("class", "data2");
}
