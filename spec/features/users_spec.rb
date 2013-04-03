require 'spec_helper'

feature "Users" do
  scenario "allows a user to sign in" do
    user = create(:user)

    login_user user

    visit root_path

    expect(page).to have_content 'logout'
  end
end
