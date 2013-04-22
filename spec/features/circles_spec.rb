require 'spec_helper'

feature "Circles" do
  scenario "are created by an authenticated user" do
    user = create(:user)
    circle = build(:circle)
    login_user user

    visit circles_path

    click_link "Create a Circle"
    fill_in "Name", with: circle.name
    fill_in "Motto", with: circle.motto
    fill_in "Description", with: circle.description

    expect {
    click_button "Create Circle"
    }.to change(Circle, :count).by(1)

    expect(page).to have_content circle.name
  end

  scenario "can only be edited/updated by an admin" do
    user = create(:user)
    circle = create(:circle)

    login_user user

    visit circle_path(circle)

    expect(page).not_to have_content "Edit Info"

    circle.add_admin(user)
    visit circle_path(circle)

    click_link "Edit Info"

    name = "#{circle.name} edited"
    fill_in "Name", with: name
    click_button "Update Circle"

    visit circle_path(circle)
    expect(page).to have_content name
  end

  scenario "can only be joined by a user if they are public" do
    pending
  end

  scenario "can be deleted by their creator" do
    pending
  end

  scenario "can be applied to by a user NOT in the circle and then be approved by a circle admin" do
    pending
  end

  scenario "user can join a circle" do
    pending
  end
end
