require 'rails_helper'

feature 'User manages their profile info' do
	let(:user) { create(:user) }
	before :each do
		login_user user
	end

	scenario 'user can visit their profile page' do
		visit root_path
		expect(page).to have_link user.username
		click_link user.username

		expect(page).to have_content "My Profile"
	end

	scenario 'edits their profile information' do
		visit athletes_path(user)
		
		click_link "Edit"
		date = 20.years.ago
		select_log_date(date, "date_of_birth")
		within "#height" do
			fill_in "Feet", with: "5"
			fill_in "Inches", with: "10"
		end

		select "Male", from: "Gender"

		click_button "Save"

		expect(page).to have_content "5'10\""
		expect(page).to have_content "Male"
		expect(page).to have_content format_date(date)
	end

	scenario 'has appropriate units based on preferences' do
		pending
	end
end
