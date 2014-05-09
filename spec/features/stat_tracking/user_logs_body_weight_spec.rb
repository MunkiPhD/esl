require 'spec_helper'

feature 'Body weight stats' do
	scenario 'User logs body weight entry' do
		Timecop.freeze(Date.today) do
		visit body_weights_path
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
			date_str = 	format-date(Date.today)
			expect(page).to have_content "200"
			expect(page).to have_content date_str
		end
		end
	end
end
