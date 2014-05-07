require 'spec_helper'

feature 'Body weight stats' do
	scenario 'User logs body weight entry' do
		visit stats_body_weight_path
		expect(page).to have_content 'Body Weight'

		within '#body_weight_entries' do
			expect(page).to_not have_content "200"
		end
		
		within '#new_body_weight' do
			fill_in "Weight", with: "200"
			select "lbs", from: '#unit'
			click_button 'Save'
		end

		expect(page).to have_content "Body Weight entry logged!"
		within '#body_weight_entries' do
			expect(page).to have_content "200"
		end
	end
end
