function SubmitOnEnter(event){
	if (event.which != 13) {
		return;
	}

	// Prevent form submit
	event.preventDefault();

	// Submit the form.
	$(event.target).closest('form').submit();	
}


$(document).ready(function(){
	$('#search').keypress(function(e){
		SubmitOnEnter(e);
	});

	$('#body_weight_weight').keypress(function(e){
		SubmitOnEnter(e);
	});

	$('#user_password').keypress(function(e){
		SubmitOnEnter(e);
	});

	$('#user_password_confirmation').keypress(function(e){
		SubmitOnEnter(e);
	});
});
