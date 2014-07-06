require 'rails_helper'

feature 'User logs a workout from a template' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'views the template page and clicks on the log workout button which builds prefilled new workout page with the same title' do
		template = create(:workout_template, user: user)	
		visit workout_template_path(template)
		
		click_link 'Log Workout'

			expect(page.find('#workout_title').value).to eq template.title
		
		click_button 'Save Workout'

		expect(page).to have_content template.title
	end

	scenario 'the build workout has the same exercises and sets as the template' do
		fail
	end

	scenario 'if a template has a one rep max exercise set, it gets the ORM for that exercise (for the user) and sets it as the weight for that set' do
		fail
	end

	scenario 'if a set has an ORM, but the user has not logged that exercise, it sets the weight as zero and displays a mesasge that no ORM was available' do
		fail
	end
end
