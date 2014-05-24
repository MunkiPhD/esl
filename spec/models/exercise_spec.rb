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
	it_behaves_like 'nice urls' do
		let(:model) { create(:exercise, name: "Barbell Squat with }][ something") }
	end

	it 'has a valid factory' do
		expect(build(:exercise)).to be_valid
	end

	describe 'validations' do
		it "has a name" do
			exercise = Exercise.new(name: '')
			exercise.valid?
			expect(exercise.errors[:name]).to include("can't be blank") #have(2).errors_on(:name)
		end

		it "name is invalid if less than 3 characters" do
			expect(Exercise.new(name: "12")).to have(1).errors_on(:name)
		end

		it "name is valid for 60 chars and less" do
			exercise = Exercise.new
			exercise.name = "1"*61
			expect(exercise).to have(1).error_on(:name)
		end

		it "has a unique name" do
			exercise = create(:exercise, name: "deadlift")
			exercise2 = build(:exercise, name: "deadlift")
			expect(exercise2).to have(1).errors_on(:name)
		end

		context 'associations' do
			it 'has an exercise type' do
				expect(Exercise.new(exercise_type: nil)).to have(1).errors_on(:exercise_type)
			end	

			it 'has equipment' do
				expect(Exercise.new(equipment: nil)).to have(1).errors_on(:equipment)
			end

			it 'has a mechanic type' do
				expect(Exercise.new(mechanic_type: nil)).to have(1).errors_on(:mechanic_type)
			end

			it 'has a force type' do
				expect(Exercise.new(force_type: nil)).to have(1).errors_on(:force_type)
			end

			it 'has a experience level' do
				expect(Exercise.new(experience_level: nil)).to have(1).errors_on(:experience_level)
			end
		end
	end



	describe 'delegates' do
		let(:exercise) { create(:exercise) }
		%w(muscle exercise_type equipment mechanic_type force_type experience_level).each do |type|
			describe "##{type}_name" do
				it "returns the #{type} name" do
					expect(exercise.send("#{type}_name")).to eq exercise.send("#{type}").name
				end
			end
		end
	end


	describe '.with_main_muscle' do
		it 'scopes to exercises with the specified muscle as the main' do
			muscle = create(:muscle)
			exercise_one = create(:exercise, muscle: muscle)
			exercise_two = create(:exercise, muscle: muscle)
			exercise_excluded = create(:exercise, muscle: nil)

			expect(Exercise.with_main_muscle(muscle)).to eq [exercise_two, exercise_one]
		end
	end
end
