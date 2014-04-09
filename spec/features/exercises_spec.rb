require 'spec_helper'

feature "Exercises" do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user) }

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

  scenario "can delete an exercise not tied to a workout" do
    pending
  end

  scenario "cannot delete an exercise without permission" do
    workout_set = create(:workout_set)

    expect {
      login_user user
      visit exercises_path
      click_link workout_set.exercise.name
      within ".button_to" do
        click_button('Delete')
      end
    }.to_not change(Exercise, :count)
  end
end
