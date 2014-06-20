require 'rails_helper'

RSpec.describe WorkoutSetTemplate, :type => :model do
	it 'returns exercise name' do
		workout_set = build(:workout_set_template)
		expect(workout_set.exercise_name).to eq workout_set.exercise.name
	end

	describe "#for_exercise" do
		it 'retrieves workout sets for the specified exercise' do
			exercise = create(:exercise)
			workout_set1 = create(:workout_set_template, exercise: exercise)
			workout_set2 = create(:workout_set_template, exercise: create(:exercise))
			expect(WorkoutSetTemplate.for_exercise(exercise)).to eq [workout_set1]
		end
	end

	describe "#by_weight_desc" do
		it 'orders the workout sets by weight, highest first' do
			workout_set1 = create(:workout_set_template, weight: 100)
			workout_set2 = create(:workout_set_template, weight: 300)
			workout_set3 = create(:workout_set_template, weight: 200)
			expect(WorkoutSetTemplate.by_weight_desc).to eq [workout_set2, workout_set3, workout_set1]
		end
	end

	describe "validations" do

		context "with valid data" do
			it "has a valid factory" do
				expect(build(:workout_set_template)).to be_valid
			end

			it "is valid with a workout exercise" do
				workout_set = WorkoutSetTemplate.new(workout_exercise_id: 1)
				workout_set.valid?
				expect(workout_set.errors[:workout_exercise_tempalte_id]).to eq []
			end

			it "set number is greater than or equal to 1" do
				workout_set = WorkoutSetTemplate.new(set_number: 1)
				workout_set.valid?
				expect(workout_set.errors[:set_number]).to eq []
			end

			it "rep number must be greater than or equal to 0" do
				workout_set = WorkoutSetTemplate.new(rep_count: 0)
				workout_set.valid?
				expect(workout_set.errors[:rep_count]).to eq []
			end

			it "notes can be empty" do
				workout_set = WorkoutSetTemplate.new(notes:nil)
				workout_set.valid?
				expect(workout_set.errors[:notes]).to eq []
			end

			it "notes must be less than 250 characters" do
				workout_set = WorkoutSetTemplate.new(notes: "a"*250)
				workout_set.valid?
				expect(workout_set.errors[:notes]).to eq []
			end

			it 'defaults with percentage of one rep max to be false' do
				workout_set_templ = WorkoutSetTemplate.new
				expect(workout_set_templ.is_percent_of_one_rep_max).to eq false
			end

			it 'percent of one rep max must be greater than zero' do
				fail
			end

			it 'percent of one rep max is valid only if is_percent_of_one_rep_max is true' do
				fail
			end
		end

		context "is invalid if" do
			it "without a workout exercise when saving" do
				expect {
					build(:workout_set_template, workout_exercise_id: nil).save
				}.to change(WorkoutSetTemplate, :count).by(0)
			end


			it "set number is null" do
				workout_set = WorkoutSetTemplate.new(set_number: nil)
				workout_set.valid?
				expect(workout_set.errors[:set_number]).to include "can't be blank"
			end

			it "rep number is null" do
				workout_set = WorkoutSetTemplate.new(rep_count: nil)
				workout_set.valid?
				expect(workout_set.errors[:rep_count]).to include "can't be blank"
			end

			it "set number is zero" do
				workout_set = WorkoutSetTemplate.new(set_number: 0)
				workout_set.valid?
				expect(workout_set.errors[:set_number]).to include "must be greater than or equal to 1"
			end

			it "rep number is less than zero" do
				workout_set = WorkoutSetTemplate.new(rep_count:-1)
				workout_set.valid?
				expect(workout_set.errors[:rep_count]).to include "must be greater than or equal to 0"
			end

			it "notes is longer than 250 chars" do
				workout_set = WorkoutSetTemplate.new(notes: "1" * 251)
				workout_set.valid?
				expect(workout_set.errors[:notes]).to include "is too long (maximum is 250 characters)"
			end

			it "only accepts whole numbers for sets" do
				workout_set = WorkoutSetTemplate.new(set_number: 1.1)
				workout_set.valid?
				expect(workout_set.errors[:set_number]).to include "must be an integer"
			end

			it "only accepts whole numbers for rep_count" do
				workout_set = WorkoutSetTemplate.new(rep_count: 1.1)
				workout_set.valid?
				expect(workout_set.errors[:rep_count]).to include "must be an integer"
			end
		end
	end

end
