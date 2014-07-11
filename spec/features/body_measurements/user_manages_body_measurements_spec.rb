require 'rails_helper.rb'

feature 'user manages their body measurements' do
	scenario 'can log a body measurement' do
		visit root_path
		click_link "Body Measurements"

		click_link "Record Measurements"

		fill_in "Chest Size", with: "53"

		click_button "Save Measurements"
		expect(page).to have_contents "Body measurements saved."
	end
end
