# == Schema Information
#
# Table name: workout_exercise_templates
#
#  id                  :integer          not null, primary key
#  workout_template_id :integer          not null
#  exercise_id         :integer          not null
#

require 'rails_helper'

RSpec.describe WorkoutExerciseTemplate, :type => :model do
	context "validations" do
		it "has a valid factory" do
			expect(build(:workout_exercise_template)).to be_valid
		end

		it "has a workout" do
			workout_exercise = WorkoutExerciseTemplate.new(workout_template_id: 1)
			workout_exercise.valid?
			expect(workout_exercise.errors[:workout_id]).to eq []
		end

		it "has an exercise" do
			workout_exercise = WorkoutExerciseTemplate.new(exercise_id: 1)
			workout_exercise.valid?
			expect(workout_exercise.errors[:exercise]).to eq []
		end
	end

	context "in-valid data" do
		it "missing workout id will not save" do
			expect {
				build(:workout_exercise_template, workout_template_id: nil).save 
			}.to change(WorkoutExerciseTemplate, :count).by(0)
		end

		it "missing exercise id will not save" do
			expect {
				build(:workout_exercise_template, exercise_id: nil).save 
			}.to change(WorkoutExerciseTemplate, :count).by(0)
		end
	end
end
