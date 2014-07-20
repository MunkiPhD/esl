require 'rails_helper'

feature 'Visitor manages body measurements' do
	scenario 'attempts to view and is redirected to homepage to sign in' do
		visit body_measurements_path
		expect(page).to have_content "sign in or sign up"
		expect(page).to have_link 'login'
	end
end
