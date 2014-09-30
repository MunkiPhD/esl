$(document).on('click', '#btn_add_workout_exercise', function(e){
	e.preventDefault();
	AddNewWorkoutExercise();
	return false;
});


$(document).on('click', "a.btn-add-set", function (e) {
	e.preventDefault();
	var $container = $(this).parents('tr');
	AddWorkoutSetToContainer($container);
	return false;
});


$(document).on('click', 'a.btn-remove-set', function(){
	$(this).prev("input[name*='_destroy']").val(true);
	$(this).parents('tr.workout-set').fadeOut('slow', function(){
		RecalculateSetNumbers($(this).parents(".workouts_workout_exercise")[0]);
	});
	return false;
});



$(document).on('click', 'a.btn-remove-exercise', function(){
	$(this).prev("input[name*='_destroy']").val(true);
	$(this).parents('table').fadeOut('slow');
	return false;
});


function RecalculateSetNumbers(exerciseContainer){
	//set the displayed and actual rep number
	var counter = 1;
	$(exerciseContainer).find(".set-number").filter(":visible").each(function(index){
		$(this).next(".set-field").val(counter);
		$(this).html(counter);
		counter += 1;
	});
}


function AddWorkoutSetToContainer(containerId) {
	var $container = $(containerId);

	var current_sets_count = $container.parents(".workouts_workout_exercise").find(".set-number").filter(":visible").length; //closest('.workouts_workout_exercise').find(".set-number").length;
	var set_number = current_sets_count + 1;
	var workout_exercise_index = $container.parents("table").data('index');
	var workout_set_id = GenerateUniqueId();

	var templateHtml = $("#template_workout_set").html();
	Mustache.parse(templateHtml);
	var rendered = Mustache.render(templateHtml, { set_number: set_number, workout_exercise_index: workout_exercise_index, workout_set_id: workout_set_id });
	var $rendered = $(rendered);


	$rendered.insertBefore($container).slideDown('slow');
	return false;
}


function AddNewWorkoutExercise() {
	var workout_exercise_index = GenerateUniqueId();

	var templateHtml = $("#template_workout_exercise").html();
	Mustache.parse(templateHtml);
	var rendered = Mustache.render(templateHtml, { workout_exercise_index: workout_exercise_index });
	var $rendered = $(rendered);

	var exerciseOptions = GetExerciseOptions();  //GenerateExerciseOptions(exercises);
	$rendered.find("select.exercise-select").html(exerciseOptions);
	AddWorkoutSetToContainer($rendered.find("tbody>tr"));

	$rendered.appendTo("#workout_exercises_container").slideDown('fast'); 
}


function GetExerciseOptions(){
	//this is a TOTAL hack, but will have to do for the time being
	return $("select.exercise-select").filter(":first").html();
}


function GenerateUniqueId() {
	var time = new Date().getTime();
	while (time == new Date().getTime());
	return new Date().getTime();
}
