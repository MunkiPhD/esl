require 'rails_helper'

describe WorkoutTemplate do
	let(:user) { create(:user) }

	describe 'validations' do
		it 'has a valid factory' do
			expect(create(:workout_template)).to be_valid
		end

		describe 'title' do
			it 'cant be blank' do
				workout_templ = WorkoutTemplate.new(title: nil)
				workout_templ.valid?
				expect(workout_temp.errors[:title]).to include "can't be blank"
			end

			it 'is not unique between users' do
				user = create(:user)
				workout_templ = create(:workout_template, title: "test", user: user)

				user2 = create(:user)
				workout_templ2 = build(:workout_template, title: "test", user: user2)
				workout_templ2.valid?
				expect(workout_templ2.errors[:title]).to eq []
			end

			it 'adds a number to the end if a user has another template with the same name' do
				workout_templ = create(:workout_template, user: user, title: "test")
				workout_templ2 = create(:workout_template, user: user, title: "test")
				workout_templ2.reload
				expect(workout_templ2.title).to eq "test (2)"
			end
		end

		describe 'user' do
		it 'cannot be blank' do
			workout_templ = WorkoutTemplate.new(user: nil)
			workout_templ.valid?
			expect(workout_templ.errors[:user]).to include "can't be blank"
		end
		end

		describe 'notes' do
			it 'can be blank' do
				workout_templ = WorkoutTemplate.new(notes: nil)
				workout_templ.valid?
				expect(workout_templ.errors[:notes]).to eq []
			end
		end
	end

	describe '.from_workout' do
		it 'creates a deep copy from the specified workout' do
			workout = create(:workout)
			workout_templ = WorkoutTemplate.from_workout(workout)

			#  id                  :integer          not null, primary key
			#  set_number          :integer          not null
			#  rep_count           :integer          not null
			#  weight              :integer          not null
			#  notes               :string(255)      default(""), not null
			#  workout_exercise_id :integer          not null
			#  created_at          :datetime
			#  updated_at          :datetime
			#  exercise_id         :integer          not null
			#  workout_id          :integer          not null
			expect(workout_templ.user).to eq workout.user
			expect(workout_templ.title).to eq workout.title
			expect(workout_templ.notes).to eq workout.notes

			for i in 0..workout_templ.workout_sets.size
				templ = workout_templ.workout_sets[i]
				orig = workout.workout_sets[i]
				expect(templ.set_number).to eq orig.set_number
				expect(templ.rep_count).to eq orig.rep_count
				expect(templ.weight).to eq orig.weight
				expect(templ.exercise_id).to eq orig.exercise_id
			end
		end
	end	
end
