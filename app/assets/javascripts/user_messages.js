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
	var $container = $("#flash_messages");
	$container.slideUp(400, function(){
		$container.empty();
		var templateHtml = $(templateId).html();
		Mustache.parse(templateHtml);
		var rendered = Mustache.render(templateHtml, { message: messageText });
		$container.append(rendered).slideDown();
	});
}
