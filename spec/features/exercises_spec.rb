require 'spec_helper'

feature "Exercises" do
  let(:user) { create(:user) }

  scenario "can create an exercise" do
    login_user user

    visit root_path
    expect(page).to have_link "exercises"

    click_link "exercises"

    click_link "Add Exercise"

    exercise = build(:exercise)
    fill_in "Name", with: exercise.name

    click_button "Create Exercise"

    expect(page).to have_content exercise.name

    visit exercises_path
    click_link exercise.name

    expect(page).to have_content exercise.name
  end

  scenario "can edit and update an exercise" do
    pending
  end

  scenario "cannot delete an exercise without permission" do
    pending
  end
end