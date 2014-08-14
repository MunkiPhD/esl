require 'rails_helper'

feature 'Visitor manages info' do
	scenario 'attempts to change info, but is redirected to sign in page' do
		user = create(:user)
		visit athlete_path(user)

		expect(page).to have_text "You need to sign in or sign up"
	end
end
