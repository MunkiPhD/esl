require 'rails_helper.rb'

feature 'user manages their body measurements' do
	scenario 'can log a single body measurement' do
		visit root_path
		click_link "Body Measurements"

		click_link "Record Measurements"

		fill_in "Chest", with: "53"

		click_button "Save Measurements"
		expect(page).to have_content "Body measurements saved."
		expect(page).to have_content "Chest: 53 in." 
		expect(page).to have_content "Arms: not measured"
	end


	scenario 'by recording multiple points of measurement data' do
		visit body_measurements_path
		click_link 'Record Measurements'

		fill_in 'Thighs', with: '47'
		fill_in 'Neck', with: '17'

		click_button 'Save Measurements'

		expect(page).to have_content 'Thighs: 47 in.'
		expect(page).to have_content 'Neck: 17 in.'
	end


	scenario 'can edit existing measurement data' do
		fail		
	end


	scenario 'can delete an existing measurement point of data' do
		fail
	end


	scenario 'defaults to the current date when creating a new entry point' do
		fail
	end
end
