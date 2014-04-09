require 'spec_helper'

feature "Exercises" do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user) }

  before :each do
    login_user user
  end

  scenario "can create an exercise" do
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
    exercise = create(:exercise, user: user)

    expect {  
      visit exercises_path
      click_link exercise.name
      within '.button_to' do
        click_button('Delete')
      end
    }.to change(Exercise, :count).by -1
  end

  scenario "cannot delete an exercise tied to a workout" do
    exercise = create(:exercise, user: user)
    workout_set = create(:workout_set, exercise: exercise)

    expect {
      visit exercises_path
      click_link exercise.name
      within '.button_to' do
        click_button('Delete')
      end
    }.to change(Exercise, :count).by 0
    expect(page).to have_content "You cannot delete an exercise that has already been logged in a workout."
  end

  scenario "cannot delete an exercise without permission" do
    workout_set = create(:workout_set)

    expect {
      visit exercises_path
      click_link workout_set.exercise_name
      within ".button_to" do
        click_button('Delete')
      end
    }.to_not change(Exercise, :count)
  end
end
