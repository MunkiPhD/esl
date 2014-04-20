var Security = Security || {};

Security.GetCSRFToken = function() {
	var securityToken = $("meta[name=csrf-token]").attr("content");
	return securityToken;
};
