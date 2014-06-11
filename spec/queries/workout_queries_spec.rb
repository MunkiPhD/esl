require 'rails_helper'

describe WorkoutQueries do
	describe '.max_weight_for_exercise_and_user' do
		it 'retrieves the correct workout for the user' do
			user = create(:user)
			workout = create(:workout_with_exercises, user: user)
			exercise = workout.workout_sets.first.exercise

			result = WorkoutQueries.max_weight_for_exercise_and_user(exercise, user).first
			expect(result.id).to eq workout.id
			expect(result.weight).to eq  300
		end
	end
end
