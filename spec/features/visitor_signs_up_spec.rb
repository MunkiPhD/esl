require 'spec_helper'

feature "Visitor signs up" do
  let(:user) { build(:user) }

  scenario "with a valid email and password" do
    sign_up_with user.username, user.email, user.password
    expect(page).to have_content('logout')
  end

  scenario "with an invalid username" do
    sign_up_with '', user.email, user.password
  end

  scenario "with an invalid email" do
    sign_up_with user.username, "invalid_email", user.password
    expect(page).to have_content("Sign in")
  end

  scenario "with a blank password" do
    sign_up_with user.username, user.email, ''
    expect(page).to have_content("Sign in")
  end


  def sign_up_with(username, email, password)
    visit new_user_registration_path

    fill_in 'Username', with: username
    fill_in 'Email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
  end
end
