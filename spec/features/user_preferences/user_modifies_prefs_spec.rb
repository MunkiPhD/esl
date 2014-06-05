require 'spec_helper'

feature 'User modifies their preferences' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'can change their default unit system' do
		visit user_preferences_path

		expect(page).to have_content 'Default Unit System: US'
		expect(page).to have_content 'Weight: Pounds (lbs)'

		click_link 'Edit Preferences'
		select 'Metric System', from: 'Default Unit System'
		
		click_button 'Save'
		expect(page).to have_content 'Default Unit System: METRIC'
		expect(page).to have_content 'Weight: Kilograms (kgs)'
	end
end
