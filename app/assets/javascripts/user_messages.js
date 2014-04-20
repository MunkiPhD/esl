var UserMessages = window.UserMessaeges || {};

UserMessages.DisplayError = function(message){
	UserMessage.DisplayMessage("#template_alert_error", message);
	return true;
}

UserMessages.DisplaySuccess = function(message){
	UserMessages.DisplayMessage("#template_alert_success", message);
	return true;
}

UserMessages.DisplayMessage = function(templateId, messageText){
	$("#flash_messages").empty();
	var templateHtml = $(templateId).html();
	Mustache.parse(templateHtml);
	var rendered = Mustache.render(templateHtml, { message: messageText });
	$("#flash_messages").append(rendered);
}
