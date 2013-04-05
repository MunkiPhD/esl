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
        fill_in "Set number", with: "1"
        fill_in "Rep count", with: "2"
        fill_in "Weight", with: "225"
      end

    expect {
      click_button "Create Workout"
    }.to change(Workout, :count).by(1)

    expect(page).to have_content "back exercise" # redirects to the index
    expect(page).to have_content("logout")
  end
end
