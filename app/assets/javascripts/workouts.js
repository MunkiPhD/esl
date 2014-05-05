//console.clear();
//http://jsfiddle.net/MunkiPhD/gJHL4/

function Workout(id) {
    this.id = id;
    this.date_performed = new Date();
    this.notes = "";
    this.title = "";
    this.workout_exercises = [];
}

Workout.prototype.AddWorkoutExercise = function AddWorkoutExerciseFunction(workoutExercise) {
    workoutExercise.workout_id = this.id;
    this.workout_exercises.push(workoutExercise);
}

function WorkoutExercise(id) {
    this.id = id;
    this.workout_id = -1;
    this._destroy = false;
    this.exercise_id = -1;

    this.workout_sets = [];
}

WorkoutExercise.prototype.AddSet = function AddSetFunction(workoutSet) {
    workoutSet.exercise_id = this.exercise_id;
    this.workout_sets.push(workoutSet);
}

function WorkoutSet(id) {
    this.id = id;
    this.set_number = 0;
    this.rep_count = 0;
    this.weight = 0;
    this.exercise_id = -1;
    this.workout_id = "";
    this._destroy = false;
}

var exercises = [{
    id: 1,
    name: "squat"
}, {
    id: 2,
    name: "deadlift"
}, {
    id: 3,
    name: "bench"
}];

var x = new Workout(2);
console.log(x.WorkoutExercises);

$(document).on('click', '#btn_add_workout_exercise', function(e){
		  console.log("in the handler");
	e.preventDefault();
	AddNewWorkoutExercise();
   return false;
});

//$(document).ready(function () {
    //$("#btn_add_workout_exercise").on('click', function (e) {
    //});

$(document).on('click', '#btn_add_new_exercise', function (e) {
		  e.preventDefault();
		  var id = GenerateUniqueId();
		  var name = "test-" + id;
		  exercises.push({
					 id: id,
					 name: name
		  });
		  console.log(exercises);
		  $("select.exercise-select").each(function () {
					 var selectedOption = $(this).find(":selected").val();
					 $(this).empty();
					 $(this).html(GenerateExerciseOptions(exercises));
					 console.log(selectedOption);
					 $(this).find("option[value='" + selectedOption + "']").attr("selected", "selected");
		  });
});

$(document).on('click', '#btn_generate_json', function (e) {
		  e.preventDefault();
		  CreateWorkoutObject();
		  return false;
});

$(document).on('click', "a.btn-add-set", function (e) {
	e.preventDefault();
    //var $container = $(this).prev();
	var $container = $(this).parents('tr');
    console.log($container);
    AddWorkoutSetToContainer($container);
});

$(document).on('click', 'a.btn-remove-set', function(){
   $(this).prev("input[name='_destroy']").val(true);
    $(this).parent('.workout-set').fadeOut('slow');
    return false;
});

function AddWorkoutSetToContainer(containerId) {
    var $container = $(containerId);
    var templateHtml = $("#template_workout_set").clone().hide();
    var id = GenerateUniqueId();
    templateHtml.attr('id', id);
    //console.log(templateHtml);

    //console.log(templateHtml);
	 //console.log($container);
    $(templateHtml).insertBefore($container).slideDown('fast');
    return false;
}


function AddNewWorkoutExercise() {
    var id = GenerateUniqueId();
    var workoutExercise = new WorkoutExercise(id);
    var templateHtml = $("#template_workout_exercise").clone().hide();
    templateHtml.attr('id', id);
  
    var exerciseOptions = GenerateExerciseOptions(exercises);
    templateHtml.find("select.exercise-select").html(exerciseOptions);
    AddWorkoutSetToContainer(templateHtml.find("tbody>tr"));
    
    $(templateHtml).appendTo("#workout").slideDown('fast'); 
  }

function GenerateExerciseOptions(exercises) {
    var options = "";
    for (var i = 0; i < exercises.length; i++) {
        options += '<option value="' + exercises[i].id + '">' + exercises[i].name + '</option>';
    }

    return options;
}

function GenerateUniqueId() {
    var time = new Date().getTime();
    while (time == new Date().getTime());
    return new Date().getTime();
}



function CreateWorkoutObject() {
    console.log("generationg json...");
    var $workout = $("#workout");
    var workoutJSON = {};
    var workout = new Workout();

    $("#workout .workout-exercise-container").each(function () {
        var workoutExercise = new WorkoutExercise(GenerateUniqueId());
        workoutExercise.exercise_id = $(this).find("select[name='exercise-select'] :selected").val();

        $(this).find(".workout-set").each(function () {
            var workoutSet = new WorkoutSet(GenerateUniqueId());
            workoutSet.rep_count = $(this).find("input[name='reps']").val();
            workoutSet.weight = $(this).find("input[name='weight']").val();
				workoutSet._destroy = $(this).find("input[name='_destroy']").val();

            workoutExercise.AddSet(workoutSet);
        });
        workout.AddWorkoutExercise(workoutExercise);
    });
    console.log(workout);
	 var jsonStr = JSON.stringify(workout);
	 console.log(jsonStr);
}
