require 'spec_helper'

feature "Users" do
  scenario "allows a user to sign in" do
    user = create(:user)
    visit root_path

    click_link "login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"
    visit root_path

    expect(page).to have_content 'logout'
  end
end
