var Security = window.Security || {};

Security.GetCSRFToken = function() {
	var securityToken = $("meta[name=csrf-token]").attr("content");
	return securityToken;
};

Security.CheckStatusCode = function(xhr, status, error) {
	console.log("Error code: " + error);
	console.log(xhr);

	if(xhr.status == 401){ //un-authorized (not logged in)
		window.location = "/";
		return false;
	} else {
		UserMessages.DisplayError("An error occured while attempting to perform the desired action.");
	}
};
