# == Schema Information
#
# Table name: workout_exercises
#
#  id          :integer          not null, primary key
#  workout_id  :integer          not null
#  exercise_id :integer          not null
#

require 'rails_helper'

describe WorkoutExercise do
	context "validations" do
		it "has a valid factory" do
			expect(build(:workout_exercise)).to be_valid
		end

		it "has a workout" do
			workout_exercise = WorkoutExercise.new(workout_id: 1)
			workout_exercise.valid?
			expect(workout_exercise.errors[:workout_id]).to eq []
		end

		it "has an exercise" do
			workout_exercise = WorkoutExercise.new(exercise_id: 1)
			workout_exercise.valid?
			expect(workout_exercise.errors[:exercise]).to eq []
		end
	end

	context "in-valid data" do
		it "missing workout id will not save" do
			expect {
				build(:workout_exercise, workout_id: nil).save 
			}.to change(WorkoutExercise, :count).by(0)
		end

		it "missing exercise id will not save" do
			expect {
				build(:workout_exercise, exercise_id: nil).save 
			}.to change(WorkoutExercise, :count).by(0)
		end
	end
end
