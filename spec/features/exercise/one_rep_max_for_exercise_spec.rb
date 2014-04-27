require 'spec_helper'

feature 'Can view the one rep max for an individual exercise' do
	NO_1RM_MESSAGE = "No Data"
	let(:user) { create(:user) }

	before :each do
		login_user user
	end

	scenario 'user visits exercise page and sees one rep max and calculated one rep max' do
		exercise = create(:exercise)
		workout = create(:workout_with_exercises, user: user)
		workout_set = build(:workout_set, rep_count: 10, weight: 315, exercise: exercise)
		workout.workout_sets << workout_set 
		workout.save!

		one_rm = OneRepMax.epley_formula(workout_set.weight, workout_set.rep_count)

		visit exercise_path(exercise)
		within "#one_rep_max" do
			expect(page).to have_content "Calculated ORM"
			expect(page).to have_content one_rm.to_i
			expect(page).to have_content "Logged Max Weight:"
			expect(page).to have_content workout_set.weight
		end
	end

	scenario 'user has not logged any workouts with said exercise' do
		exercise = create(:exercise)
		visit exercise_path(exercise)
		within "#one_rep_max" do
			expect(page).to have_content NO_1RM_MESSAGE
		end
	end
end
