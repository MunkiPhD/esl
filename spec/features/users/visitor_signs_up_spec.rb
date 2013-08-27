require 'spec_helper'

feature "Visitor signs up" do
  let(:user) { build(:user) }

  scenario "with a valid email and password" do
    sign_up_with user.username, user.email, user.password, 1
    expect(page).to have_content('logout')
  end

  scenario "with an invalid username" do
    sign_up_with '', user.email, user.password, 0
    expect(page).to have_text "Only alphanumeric letters and underscores allowed"
    expect(page).to have_button "Sign up"
  end

  scenario "with an invalid email" do
    sign_up_with user.username, "invalid_email", user.password, 0
    expect(page).to have_content("Sign up")
  end

  scenario "with a blank password" do
    sign_up_with user.username, user.email, '', 0
    expect(page).to have_text "Password can't be blank"
    expect(page).to have_button "Sign up"
  end


  def sign_up_with(username, email, password, count_change)
    visit new_user_registration_path

    expect {
      fill_in 'Username', with: username
      fill_in 'Email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button 'Sign up'
    }.to change(User, :count).by(count_change)
  end
end
