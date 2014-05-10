require 'spec_helper'

feature 'Body weight stats' do
	context 'User is signed in' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'User logs body weight entry' do
		Timecop.freeze(Date.today) do
			visit body_weights_path
			expect(page).to have_content 'Body Weight'

			within '#body_weight_entries' do
				expect(page).to_not have_content "200"
			end

			within '#new_body_weight' do
				fill_in "Weight", with: "200"
				click_button 'Save'
			end

			expect(page).to have_content "Body Weight entry logged!"
			within '#body_weight_entries' do
				date_str = Date.today.strftime('%d-%B-%Y')
				expect(page).to have_content "200"
				expect(page).to have_content date_str
			end
		end
	end
	end
end
