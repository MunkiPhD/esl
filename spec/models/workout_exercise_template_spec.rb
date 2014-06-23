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

	describe '#exercise_name' do
		it 'returns the name of the exercise' do
			workout_exercise = create(:workout_exercise_template)
			expect(workout_exercise.exercise_name).to eq workout_exercise.exercise.name
		end
	end

	describe '.from_workout_exercise' do
		it 'creates a copy with the workout exercise properties' do
			workout_exercise = build(:workout_exercise)
			templ = WorkoutExerciseTemplate.from_workout_exercise(workout_exercise)
			expect(templ.exercise_id).to eq workout_exercise.exercise_id
		end

		it 'copies the workout sets' do
			workout_exercise = create(:workout_exercise)
			workout_exercise.workout_sets.build(build(:workout_set).attributes)
			workout_exercise.workout_sets.build(build(:workout_set).attributes)
			expect(workout_exercise.workout_sets.size).to eq 2
			templ = WorkoutExerciseTemplate.from_workout_exercise(workout_exercise)

			expect(templ.workout_set_templates.size).to eq 2
			expect(workout_exercise.workout_sets.size).to eq 2

			templ.workout_set_templates.each_with_index do |templ, index|
				workout_set = workout_exercise.workout_sets[index]

				expect(templ.set_number).to eq workout_set.set_number
				expect(templ.rep_count).to eq workout_set.rep_count
				expect(templ.weight).to eq workout_set.weight
				expect(templ.notes).to eq workout_set.notes
				expect(templ.exercise).to eq workout_set.exercise
			end
		end
	end
end
