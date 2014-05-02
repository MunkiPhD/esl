console.clear();
//http://jsfiddle.net/MunkiPhD/gJHL4/

function Workout(id) {
    this.id = id;
    this.DatePerformed = new Date();
    this.Notes = "";
    this.Title = "";
    this.WorkoutExercises = [];
}

Workout.prototype.AddWorkoutExercise = function AddWorkoutExerciseFunction(workoutExercise) {
    workoutExercise.WorkoutId = this.id;
    this.WorkoutExercises.push(workoutExercise);
}

function WorkoutExercise(id) {
    this.id = id;
    this.WorkoutId = -1;
    this.Destroy = false;
    this.ExerciseId = -1;

    this.WorkoutSets = [];
}

WorkoutExercise.prototype.AddSet = function AddSetFunction(workoutSet) {
    workoutSet.ExerciseId = this.ExerciseId;
    this.WorkoutSets.push(workoutSet);
}

function WorkoutSet(id) {
    this.id = id;
    this.Destroy = false;
    this.ExerciseId = -1;
    this.Reps = 0;
    this.SetNumber = 0;
    this.Weight = 0;
    this.WorkoutId = "";
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

$(document).ready(function () {
    $("#btn_add_workout_exercise").on('click', function (e) {
        AddNewWorkoutExercise();
        return false;
    });

    $("#btn_add_new_exercise").on('click', function () {
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

    $("#btn_generate_json").on('click', function () {
        CreateWorkoutObject();
        return false;
    });
});

$(document).on('click', "a.btn-add-set", function () {
    var $container = $(this).prev();
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
    $(templateHtml).appendTo($container).slideDown('fast');
    return false;
}


function AddNewWorkoutExercise() {
    var id = GenerateUniqueId();
    var workoutExercise = new WorkoutExercise(id);
    var templateHtml = $("#template_workout_exercise").clone().hide();
    templateHtml.attr('id', id);
  
    var exerciseOptions = GenerateExerciseOptions(exercises);
    templateHtml.find("select.exercise-select").html(exerciseOptions);
    AddWorkoutSetToContainer(templateHtml.find(".workout-sets-container"));
    
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
        workoutExercise.ExerciseId = $(this).find("select.exercise-select :selected").val();

        $(this).find(".workout-set").each(function () {
            var workoutSet = new WorkoutSet(GenerateUniqueId());
            workoutSet.Reps = $(this).find("input.reps").val();
            workoutSet.Weight = $(this).find("input.weight").val();

            workoutExercise.AddSet(workoutSet);

        });
        workout.AddWorkoutExercise(workoutExercise);
    });
    console.log(workout);
}
