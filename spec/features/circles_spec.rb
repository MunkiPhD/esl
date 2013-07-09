require 'spec_helper'

feature "Circles" do
  let(:user) { create(:user) }

  before :each do
    create(:exercise, id: 1)
    create(:exercise, id: 2)
    create(:exercise, id: 3)
  end

  scenario "are created by an authenticated user" do
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
    circle = create(:circle, is_public: false)

    login_user user

    visit circle_path(circle)
    expect(page).to have_button "Apply"
  end

  scenario "can be deleted by an admin if there are no other members" do
    pending
  end

  scenario "if a circle has no users, the first user to join automatically becomes the admin" do
    circle = create(:circle)
    circle.members.each { |member| circle.remove_member(member) }
    expect(circle.members.count).to eq 0

    login_user user

    visit circle_path(circle)

    expect(page).to have_button "Join"
    click_button "Join"

    expect(page).to have_link "Edit Info"
  end

  scenario "can be applied to by a user NOT in the circle and approved by an admin" do
    circle = create(:circle, is_public: false)

    login_user user

    visit circle_path(circle)
    expect(page).to have_button "Apply"

    click_button "Apply"

    expect(page).to have_content "Your membership is awaiting approval."

    logout_user

    admin = create(:user)
    circle.add_admin admin

    login_user admin

    visit circle_members_path(circle.id)
    expect(page).to_not have_content user.username

    click_link "Awaiting Approval (1)"
    #visit pending_circle_members_path(circle.id)
    expect(page).to have_content user.username
    expect(page).to have_button "Approve"

    click_button "Approve"

    visit circle_members_path(circle.id)
    expect(page).to have_content user.username
  end


  scenario "user applies for membership, but decides to cancel before he is approved" do
    circle = create(:circle, is_public: false)

    user2 = create(:user)
    login_user user2

    visit circles_path
    click_link circle.name

    expect(page).to have_button "Apply"

    click_button "Apply"

    expect(page).to have_content "Your membership is awaiting approval."

    visit circle_path(circle)

    expect(page).to have_button "Cancel Membership Request"

    click_button "Cancel Membership Request"

    expect(page).to have_content "Your membership request has been cancelled."
    expect(page).to have_button "Apply"
  end

  scenario "user can join a circle" do
    circle = create(:circle, is_public: true)

    login_user user

    visit circle_path(circle)
    expect(page).to have_button "Join"

    click_button "Join"

    visit circle_path(circle)
    expect(page).to have_link "Leave"
  end

  scenario "an admin of a private group can approve users who are pending" do
    circle = create(:circle, is_public: false)
    login_user user

    pending_member = create(:user)
    circle.add_admin(user)

    visit circle_path(circle)
    expect(page).to_not have_link pending_member.username

    circle.request_membership(pending_member)

    visit circle_path(circle)

    expect(page).to have_link("Awaiting Approval (1)")

    click_link "Awaiting Approval (1)"

    expect(page).to have_content pending_member.username
    expect(page).to have_button "Approve"

    click_button "Approve"

    visit circle_path(circle)
    expect(page).to have_content pending_member.username

  end
end
