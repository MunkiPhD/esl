# == Schema Information
#
# Table name: workouts
#
#  id             :integer          not null, primary key
#  title          :string(255)      not null
#  date_performed :date             not null
#  notes          :text             default(""), not null
#  user_id        :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

require 'rails_helper'

describe Workout do
	let(:user) { create(:user) }

	describe "is valid with" do
		it "has a valid factory" do
			expect(build(:workout)).to be_valid
		end

		it "has a valid factory with exercises" do
			workout = build(:workout_with_exercises)
			expect(workout).to be_valid
		end

		it "builds the factory with the exercises and sets" do
			workout = build(:workout_with_exercises)
			expect(workout.workout_exercises.length).to eq(1)
			expect(workout.workout_exercises[0].workout_sets.length).to eq(3)
		end

		it "saves a workout with nested attributes" do
			workout = build(:workout_with_exercises)
			workout.save
			workout.reload
			expect(workout.workout_exercises.length).to eq(1)
			expect(workout.workout_exercises[0].workout_sets.length).to eq(3)
		end

		it "a title" do
			workout = Workout.new(title: "dsadas")
			workout.valid?
			expect(workout.errors[:title]).to eq []
		end

		it "a title less than 200 characters" do
			workout = Workout.new(title: "a" * 200)
			workout.valid?
			expect(workout.errors[:title]).to eq []
		end

		it "a date performed" do
			workout = Workout.new(date_performed: DateTime.now)
			workout.valid?
			expect(workout.errors[:date_performed]).to eq []
		end

		it "empty notes" do
			workout = Workout.new(notes: "")
			workout.valid?
			expect(workout.errors[:notes]).to eq []
		end

		it "has a user" do
			workout = Workout.new(user_id: 1)
			workout.valid?
			expect(workout.errors[:user_id]).to eq []
		end
	end


	it ":date_desc fetches workouts based on date performed, latest first" do
		workout_one = create(:workout_with_exercises, user: user, date_performed: Date.today - 3) 
		workout_two = create(:workout_with_exercises, user: user, date_performed: Date.today - 1)
		workout_three = create(:workout_with_exercises, user: user, date_performed: Date.today - 2)
		expect(user.workouts.date_desc).to eq [workout_two, workout_three, workout_one]
	end



	describe "is in-valid with" do
		it "a title longer than 200 characters" do
			workout = Workout.new(title: "a" * 201)
			workout.valid?
			expect(workout.errors[:title]).to include "is too long (maximum is 200 characters)"
		end

		it "no title" do
			workout = Workout.new(title: nil)
			workout.valid?
			expect(workout.errors[:title]).to include "can't be blank"
		end

		it "title less than 2 characters" do
			workout = Workout.new(title: "a")
			workout.valid?
			expect(workout.errors[:title]).to include "is too short (minimum is 2 characters)"
		end

		it "no date date performed" do
			workout = Workout.new(date_performed: nil)
			workout.valid?
			expect(workout.errors[:date_performed]).to include "can't be blank"
		end

		it "no user" do
			workout = Workout.new(user_id: nil)
			workout.valid?
			expect(workout.errors[:user_id]).to include "can't be blank"
		end
	end

	describe 'methods' do
		describe '.on_date' do
			it 'returns the workouts on specified date' do
				Timecop.freeze(Date.today) do
					workout_one = create(:workout, date_performed: Date.today, user: user)
					workout_two = create(:workout, date_performed: 1.week.ago, user: user)
					expect(user.workouts.on_date(Date.today)).to eq [workout_one]
				end
			end
		end

		describe '#from_template' do
			it 'creates a workout from the template with same title' do
				template = create(:workout_template_with_exercises)
				workout = Workout.from_template(template, user)
				expect(workout.title).to eq template.title
			end

			it 'creates a workout with the same workout exercises' do
				template = create(:workout_template_with_exercises, user: user)
				workout = Workout.from_template(template, user)

				workout.workout_exercises.each_with_index do |element, index|
					expect(element.exercise_name).to eq template.workout_exercise_templates[index].exercise_name
				end
			end


			it 'creates a workout with the same sets' do
				template = create(:workout_template_with_exercises, user: user)
				workout = Workout.from_template(template, user)
				
				workout.workout_exercises.each_with_index do |workout_exercise, index|
					template_exercise = template.workout_exercise_templates[index]

					workout_exercise.workout_sets.each_with_index do |workout_set, index2|
						template_set = template_exercise.workout_set_templates[index2]

						expect(workout_set.set_number).to eq template_set.set_number
						expect(workout_set.rep_count).to eq template_set.rep_count
						expect(workout_set.exercise).to eq template_set.exercise
					end
				end
			end
		end

		describe '#max_weight' do
			it "fetches an empty array for no exercise of type" do
				circle = create(:circle, user: user)
				workout = create(:workout_with_exercises, user: user)
				exercise = workout.workout_exercises[0].exercise
				circle.add_member user

				max_workouts = Leaderboard.max_weight_for_exercise_on_circle(circle, exercise)
				expect(max_workouts.blank?).to eq false

				max_workouts = Leaderboard.max_weight_for_exercise_on_circle(circle, create(:exercise))
				expect(max_workouts.blank?).to eq true
			end


			it 'fetches the workout with the highest weight' do
				workout = create(:workout_with_exercises, user: user)
				workout_1 = create(:workout_with_exercises, user: user)

				workout.workout_exercises[0].workout_sets[0].weight += 200
				workout.save

				exercise = workout.workout_exercises[0].exercise

				workout_1.workout_exercises[0].exercise = exercise
				workout_1.workout_exercises[0].workout_sets[0].weight += 100
				workout_1.save

				# a user that did the same exercise
				user2 = create(:user)
				workout2 = create(:workout_with_exercises, user: user2)
				workout2.workout_exercises[0].exercise = exercise
				workout2.workout_exercises[0].workout_sets[0].weight += 150
				workout2.save


				# a user that did a different exercise
				user3 = create(:user)
				exercise2 = create(:exercise)
				workout3 = create(:workout_with_exercises, user: user3)
				workout3.workout_exercises[0].exercise = exercise2
				workout3.workout_exercises[0].workout_sets[0].weight += 350
				workout3.save

				expect(exercise).to_not eq exercise2

				circle = create(:circle)
				circle.add_member user
				circle.add_member user2
				circle.add_member user3

				max_workouts = Leaderboard.max_weight_for_exercise_on_circle(circle, exercise)

				expect(max_workouts).to eq [workout, workout2]
			end
		end
	end
end
