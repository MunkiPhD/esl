require 'spec_helper'

feature "Workouts" do
  let(:user) { create(:user) }
  let(:workout) { create(:workout, user: user) }


  before :each do 
    login_user user
    expect(page).to have_content user.username
  end

  scenario "user can add a workout" do
    exercise = create(:exercise) 
    visit workouts_path

    click_link "new workout"
    fill_in "Title", with: "back exercise"

    last_nested_exercise = all(".workouts_workout_exercise").last

    within(last_nested_exercise) do
      select exercise.name, from: 'workout_workout_exercises_attributes_0_exercise_id'
      fill_in "workout_workout_exercises_attributes_0_workout_sets_attributes_0_rep_count", with: "2"
      fill_in "workout_workout_exercises_attributes_0_workout_sets_attributes_0_weight", with: "225"
    end

    expect {
      click_button "Create Workout"
    }.to change(Workout, :count).by(1)

    expect(page).to have_content "back exercise" # redirects to the index
    expect(page).to have_content("logout")
  end

  scenario "user can edit a workout" do
    workout = create(:workout_with_exercises, user: user)
    visit workouts_path
    expect(page).to have_content workout.title
    expect(page).not_to have_content "NewWorkoutTitle"
    click_link workout.title
    #save_and_open_page

    click_link "Edit"
    click_link "Add Exercise"
    # change the title
    fill_in "workout[title]", with: "NewWorkoutTitle"

    click_button "Update Workout"
    expect(page).to have_content "NewWorkoutTitle"
    expect(page).to have_content "Workout was successfully updated."
  end

  scenario "user can delete a workout" do
    visit workouts_path(id: workout, username: workout.user.username)
    expect(page).to have_content "Workouts"
    expect(page).to have_link workout.title

    expect {
      click_link workout.title
      click_button "Delete Workout"
      #alert = page.driver.browser.switch_to.alert
      #alert.accept
    }.to change(Workout, :count).by(-1)

    expect(page).to have_content "Workouts"
    expect(page).to_not have_link workout.title
  end

  scenario "can be viewed by another user if theyre in the same circle" do
    user2 = create(:user)
    workout2 = create(:workout, user: user2)

    circle = create(:circle)
    circle.add_member(user)
    circle.add_member(user2)

    visit user_workout_path(user2, workout2)
    expect(page).to have_content workout2.title
  end

  scenario "cannot be viewed by a user not in the same circle" do
    user2 = create(:user)
    workout2 = create(:workout, user: user2)

    circle = create(:circle)
    circle.add_member(user)

    visit user_workout_path(user2, workout2)
    expect(page).to_not have_content workout2.title
    expect(page).to have_content "You are not authorized"
  end
end
