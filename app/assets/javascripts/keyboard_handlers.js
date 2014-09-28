function SubmitOnEnter(event){
	if (event.which != 13) {
		return;
	}

	// Prevent form submit
	event.preventDefault();

	// Submit the form.
	$(event.target).closest('form').submit();	
}
