require 'rails_helper'

feature 'User manages their profile info' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'user can visit their profile page' do
		visit root_path
		click_link user.username

		within("#athlete_name") do
			expect(page).to have_content user.username
		end
	end


	scenario 'user visits another users page, only sees their username' do
		user2 = create(:user)
		visit athlete_path(user2)

		within("#athlete_name") do
			expect(page).to have_content user2.username
			expect(page).to_not have_content user.username
		end
	end

	scenario 'can see the ability to edit their information' do
		visit athlete_path(user)

		expect(page).to have_link "Edit Preferences"
		expect(page).to have_link "Edit"
	end

	scenario 'current user does not see the ability to edit their preferences and info if on another athletes page' do
		user2 = create(:user)
		visit athlete_path(user2)

		expect(page).to_not have_link "Edit Preferences"
		expect(page).to_not have_link "Edit"
	end

	scenario 'if they attempt to look at a user that does not exist, they are redirected to their profile' do
		visit athlete_path("some_random_guy_that_doesnt_exist")

		expect(page).to have_content "Athlete some_random_guy_that_doesnt_exist does not exist!"
	end


	scenario 'edits their profile information for to a male' do
		Timecop.freeze(Date.today) do
			visit root_path
			click_link user.username

			click_link "Edit"
			date = Date.new(Time.now.year - 20, Date.today.month, Date.today.day - 1)
			select_log_date(date, "user_birth_date")
			fill_in "Height", with: "70"

			select "Male", from: "Gender"

			click_button "Save"

			expect(page).to have_content "5' 10\""
			expect(page).to have_content "Male"
			expect(page).to have_content "Age: 20"
		end
	end

	scenario 'edits their profile information for to a female' do
		Timecop.freeze(Date.today) do
			visit root_path
			click_link user.username

			click_link "Edit"
			date = Date.new(Time.now.year - 22, Date.today.month, Date.today.day - 1)
			select_log_date(date, "user_birth_date")
			fill_in "Height", with: "56"

			select "Female", from: "Gender"

			click_button "Save"

			expect(page).to have_content "4' 8\""
			expect(page).to have_content "Female"
			expect(page).to have_content "Age: 22"
		end
	end

	scenario 'has appropriate units based on preferences' do
		logout_user
		prefs = create(:user_preferences_metric)

		metric_user = prefs.user
		login_user metric_user

		visit root_path
		click_link metric_user.username

		click_link "Edit"

		within(".edit_user") do
			expect(page).to have_content "cm"
			expect(page).to_not have_content "inches"
			fill_in 'Height', with: "178"
		end

		click_button "Save Info"

		expect(page).to have_content "1.78 m (5' 10\")"
	end
end
