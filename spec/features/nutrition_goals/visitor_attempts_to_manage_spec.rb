require 'rails_helper'

feature 'Visitor' do
	scenario 'attempts to edit nutrition goal' do
		visit edit_nutrition_goal_path
		expect(page).to have_text "You need to sign in or sign up"
	end
end
