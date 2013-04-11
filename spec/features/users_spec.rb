require 'spec_helper'

feature "Users" do
  scenario "allows a user to sign in" do
    user = create(:user)

    login_user user

    visit root_path

    expect(page).to have_content 'logout'
  end

  scenario "allows a user to sign in using either email or username" do
    user = create(:user)
   
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

    expect(page).to have_content 'Invalid login or password.'
  end


  scenario "allow someone to create an account" do
    user = build(:user)

    visit new_user_registration_path
    expect(page).to have_content "Sign up"

    user = build(:user)

    expect {
      fill_in 'Email', with: user.email
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password_confirmation
      click_button 'Sign up'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'logout'
  end

  pending "user can log out successfully"
  pending "can change their email and password"
end
