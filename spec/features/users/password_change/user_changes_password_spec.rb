require 'rails_helper'

feature 'User changes their password' do
	let(:user) { create(:user) }

	before :each do
		login_user user
	end


	scenario 'is taken to the change password screen by clicking on the "Change Password" link in their profile' do
		visit root_path
		click_link user.username
		click_link "Change Password"
		expect(page).to have_content "Change your password"
	end


	scenario 'displays errors if current password does not match the one provided' do
		change_user_password("somethingrRandom1234", "newpassword", "newpassword")
		expect(page).to have_content "Current password is invalid"
	end

	scenario 'displays errors if current password is blank' do
		change_user_password("", "newpassword", "newpassword")
		expect(page).to have_content "Current password can't be blank"
	end

	scenario 'displays errors if new password does not match confirmation' do
		change_user_password(user.password, "newpassword", "newpassworddifferent")
		expect(page).to have_content "Password confirmation doesn't match Password"
	end

	scenario 'provides current password, but leaves everything else blank, does not change password' do
		change_user_password(user.password, "", "")
		expect(page).to have_content "Password Updated Successfully"
		logout_user

		visit root_path

		click_link "login"
		fill_in "Login", with: user.email
		fill_in "Password", with: user.password

		click_button "Sign in"
		expect(page).to have_link user.username
		expect(page).to have_link "logout"
	end

	scenario 'changes their password and is redirected to the account page' do
		change_user_password(user.password, "newpassword", "newpassword")
		expect(page).to have_content "Password Updated Successfully"
	end


	scenario 'changes their password and the old password no longer works' do
		old_password = user.password
		change_user_password(user.password, "newpassword", "newpassword")
		logout_user

		visit root_path

		click_link "login"
		fill_in "Login", with: user.email
		fill_in "Password", with: old_password

		click_button "Sign in"

		expect(page).to have_content "Invalid login or password"
	end
	

	scenario 'changes their password and the new one works' do
		change_user_password(user.password, "newpassword", "newpassword")
		logout_user

		visit root_path

		click_link "login"
		fill_in "Login", with: user.email
		fill_in "Password", with: "newpassword"

		click_button "Sign in"

		expect(page).to have_link user.username
		expect(page).to have_link "logout"
	end


	def change_user_password(current_password, new_password, new_password_confirmation)
		visit root_path
		click_link user.username
		click_link "Change Password"

		fill_in "Current password", with: current_password
		fill_in "New password", with: new_password
		fill_in "Confirm new password", with: new_password_confirmation
		click_button "Change my password"
	end
end
