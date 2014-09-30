function readURL(input, previewElementId) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $(previewElementId).attr('src', e.target.result);
        }

        reader.readAsDataURL(input.files[0]);
    }
}

/*
$(document).ready(function(e){
	$("#food_food_image").change(function(){
		console.log("image preview initialized");
		readURL(this, "#food_image_upload_preview");
	});
});
*/
