require 'rails_helper'

feature "Users" do
	let(:user) { create(:user) }

  scenario "allows a user to sign in" do
    login_user user

    visit root_path

    expect(page).to have_content 'logout'
  end

  scenario "allows a user to sign in using either email or username" do
    visit root_path
    click_link 'login'
    fill_in "Login", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"

    expect(page).to have_content user.username
    expect(page).to have_content 'logout' 

    click_link 'logout'

    visit root_path
    click_link 'login'
    fill_in "Login", with: user.username
    fill_in "Password", with: user.password

    click_button "Sign in"

    expect(page).to have_content user.username
    expect(page).to have_content 'logout' 
  end


  scenario "someone attempts to login with invalid account information" do
    visit new_user_session_path

    user = build(:user)

    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password

    click_button "Sign in"

    expect(page).to have_content 'Invalid email address or password.'
  end


  scenario "someone attempts to login with empty email" do
    visit new_user_session_path

    click_button "Sign in"

    expect(page).to have_content 'Invalid login or password.'
  end


  scenario "allow someone to create an account" do
    visit new_user_registration_path
    expect(page).to have_content "Sign up"

    user = build(:user)

    expect {
      fill_in 'Username', with: user.username
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      click_button 'Sign up'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'logout'
  end

  scenario "user can log out successfully" do
		login_user user
		visit root_path
		expect(page).to have_content 'logout'
		click_link 'logout'
		expect(page).to have_content 'login'
	end

  skip "can change their email and password"
end
