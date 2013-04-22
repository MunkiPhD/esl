require 'spec_helper'

feature "Workouts" do
  scenario "user can add a workout" do
    user = create(:user)
    login_user user

    exercise = create(:exercise) 
    visit workouts_path

    click_link "new workout"
    fill_in "Title", with: "back exercise"

    last_nested_exercise = all(".workouts_workout_exercise").last

    within(last_nested_exercise) do
      select exercise.name, from: 'workout_workout_exercises_attributes_0_exercise_id'
      fill_in "Reps:", with: "2"
      fill_in "Weight:", with: "225"
    end

    expect {
      click_button "Create Workout"
    }.to change(Workout, :count).by(1)

    expect(page).to have_content "back exercise" # redirects to the index
    expect(page).to have_content("logout")
  end

  scenario "user can edit a workout" do
    user = create(:user)
    login_user user

    workout = create(:workout, user: user)

    visit workouts_path
    expect(page).not_to have_content "NewWorkoutTitle"
    click_link workout.title

    click_link "edit"
    click_link "Add Exercise"
    # change the title
    fill_in "workout[title]", with: "NewWorkoutTitle"

    click_button "Update Workout"
    expect(page).to have_content "NewWorkoutTitle"
    expect(page).to have_content "Workout was successfully updated."
  end

  scenario "user can delete a workouts" do
    pending
  end
end
