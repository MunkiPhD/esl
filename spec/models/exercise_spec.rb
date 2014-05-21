# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Exercise do
	describe 'validations' do
		it "has a name" do
			exercise = Exercise.new
			expect(exercise).to_not be_valid
		end

		it "has a name at least three characters long" do
			exercise = Exercise.new
			exercise.name = "123"
			expect(exercise).to be_valid

			exercise.name = "12"
			expect(exercise).to_not be_valid
		end

		it "has a name that is less than 45 characters long" do
			exercise = Exercise.new
			exercise.name = "1"*45
			expect(exercise).to be_valid
		end

		it "has a unique name" do
			exercise = create(:exercise, name: "deadlift")
			exercise2 = build(:exercise, name: "deadlift")
			expect(exercise2).to have(1).errors_on(:name)
		end
	end

	describe ".with_main_muscle" do
		it 'scopes to exercises with the specified muscle as the main' do
			muscle = create(:muscle)
			exercise_one = create(:exercise, muscle: muscle)
			exercise_two = create(:exercise, muscle: muscle)
			exercise_excluded = create(:exercise, muscle: nil)

			expect(Exercise.with_main_muscle(muscle)).to eq [exercise_two, exercise_one]
		end
	end
end
