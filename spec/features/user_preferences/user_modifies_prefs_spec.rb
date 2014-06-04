require 'spec_helper'

feature 'User modifies their preferences' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'can change their default weight unit selection' do
		visit user_preferences_path

		expect(page).to have_content 'Default Weight Unit: Pounds (lbs)'

		click_link 'Edit Preferences'
		select 'Kilograms (kg)', from: 'Default Weight Unit'
		
		click_button 'Save'
		expect(page).to have_content 'Default Weight Unit: Kilograms (kgs)'
	end
end
