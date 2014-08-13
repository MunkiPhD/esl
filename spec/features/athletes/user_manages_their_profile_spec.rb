require 'rails_helper'

feature 'User manages their profile info' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'user can visit their profile page' do
		visit root_path
		click_link user.username

		expect(page).to have_content "My Info"
	end


	scenario 'edits their profile information for to a male' do
		visit root_path
		click_link user.username
		
		click_link "Edit"
		date = 20.years.ago
		select_log_date(date, "user_birth_date")
		fill_in "Height", with: "70"

		select "Male", from: "Gender"

		click_button "Save"

		expect(page).to have_content "5' 10\""
		expect(page).to have_content "Male"
		expect(page).to have_content "Age: 20"
	end

	scenario 'edits their profile information for to a female' do
		visit root_path
		click_link user.username
		
		click_link "Edit"
		date = 22.years.ago
		select_log_date(date, "user_birth_date")
		fill_in "Height", with: "56"

		select "Female", from: "Gender"

		click_button "Save"

		expect(page).to have_content "4' 8\""
		expect(page).to have_content "Female"
		expect(page).to have_content "Age: 22"
	end

	scenario 'has appropriate units based on preferences' do
		pending
	end
end
