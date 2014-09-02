module FormHelper
	def submit_button(text)
		 button_tag class: "btn btn-success btn-large", style: "margin-top: 10px", type: 'submit' do
			content_tag(:span, nil, class: "glyphicon glyphicon-check icon-white") + " " + text
		end
	end
end
