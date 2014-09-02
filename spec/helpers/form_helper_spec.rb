require 'rails_helper'

describe FormHelper do
	describe "submit_button" do
		it 'creates a button of type submit' do
			button = helper.submit_button("Save Something")
			expect(button).to include 'type="submit"'
		end

		it 'has the text passed in' do
			button = helper.submit_button("Save Something")
			expect(button).to include 'Save Something'
		end
	end

end
