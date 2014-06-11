require 'rails_helper'

feature "Errors:" do
  let(:user) { create(:user) }

  scenario "RecordNotFound redirects to home page and displays message" do
    login_user user

    visit circle_path(131231)
    expect(current_path).to eq root_path
    expect(page).to have_content("What you were looking for... was not found!")
  end
end
