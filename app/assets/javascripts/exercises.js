function AttachHandlerToAddExercise(btnId, successBlock){
	$(btnId).on('click', function(e){
		e.preventDefault();
		var exerciseView = new ExerciseView();
		exerciseView.AjaxCreate(successBlock);
		return false;
	});
}

function AddExerciseToWorkoutList(exerciseObj){
	console.log(exerciseObj);
	var optionString = '<option value="' + exerciseObj.id + '">' + exerciseObj.name + '</option>';
	$("select[name^='workout[workout_exercises_attributes]']").append(optionString);
}



function ExerciseView() {}

ExerciseView.prototype.AjaxCreate = function(successBlock){
	var templateHtml = $("#template_create_exercise").html();
	Mustache.parse(templateHtml);
	var $rendered = $(Mustache.render(templateHtml, {}));

	var $createDialogDiv = $("#create_exercise_dialog");
	$createDialogDiv.html($rendered);

	$createDialogDiv.dialog({
		resizable: false,
		width: 550,
		modal: true,
		buttons: [
			{
			text: "Create Exercise",
			class: "btn btn-success",
			click: function(){
				$(this).dialog("close");
				var exercise = new ExerciseModel();
				exercise.Create("#new_exercise", successBlock);
				$("#create_exercise_dialog").empty();
			}
		},
		{
			text: "Cancel",
			class: "btn btn-primary",
			click: function(){
				$(this).dialog("close");
				$createDialogDiv.empty();
			}
		}
		]
	});
}



function ExerciseModel(){}

ExerciseModel.prototype.Create = function(formDivId, successBlock){
	var $form = $(formDivId);
	var actionUrl = $form.attr("action");
	var serializedData = $form.serialize();

	$.ajax({
		type: "POST",
		url: actionUrl,
		dataType: "json",
		data: serializedData
	}).done(function(data, status, xhr){
		console.log("Exercise was created successfully!");
		console.log(data);
		var successMessage = data["name"] + " was added to the exercise list";
		UserMessages.DisplaySuccess(successMessage);
		successBlock(data);

	}).fail(function(xhr, status, error){
		Security.HandleStatusCode(xhr, status, error);

	}).always(function(){
		console.log("AJAX :POST to Exercises create completed");
	});

	return true;
}
