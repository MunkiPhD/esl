# == Schema Information
#
# Table name: exercises
#
#  id                  :integer          not null, primary key
#  name                :string(255)      not null
#  created_at          :datetime
#  updated_at          :datetime
#  muscle_id           :integer
#  alternate_name      :string(255)
#  exercise_type_id    :integer          not null
#  equipment_id        :integer          not null
#  mechanic_type_id    :integer          not null
#  force_type_id       :integer          not null
#  experience_level_id :integer          not null
#  instructions        :text             default("")
#  other_muscles       :string(255)
#

require 'rails_helper'


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

		it 'other muscles can be blank' do
			exercise = build(:exercise, other_muscles: "")
			expect(exercise).to have(0).errors_on(:other_muscles)
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

	describe '.for_exercise_type' do
		it 'scopes the exercises to the specified type' do
			exercise_type = create(:exercise_type)
			exercise_one = create(:exercise, exercise_type: exercise_type)
			exercise_two = create(:exercise, exercise_type: create(:exercise_type))
			expect(Exercise.for_exercise_type(exercise_type)).to eq [exercise_one]
		end
	end

	describe '.for_equipment' do
		it 'scopes the equipment to the specified type' do
			equipment = create(:equipment)
			exercise = create(:exercise, equipment: equipment)
			exercise_excluded = create(:exercise)
			expect(Exercise.for_equipment(equipment)).to eq [exercise]
		end
	end

	describe '.for_mechanic_type' do
		it 'scopes the mechanic type to the specified mechanic' do
			mechanic_type = create(:mechanic_type)
			exercise = create(:exercise, mechanic_type: mechanic_type)
			exercise_excluded = create(:exercise)
			expect(Exercise.for_mechanic_type(mechanic_type)).to eq [exercise]
		end
	end
		
	describe '.for_muscle' do
		it 'scopes to exercises with the specified muscle as the main' do
			muscle = create(:muscle)
			exercise_one = create(:exercise, muscle: muscle)
			exercise_two = create(:exercise, muscle: muscle)
			exercise_excluded = create(:exercise, muscle: nil)

			expect(Exercise.for_muscle(muscle)).to eq [exercise_two, exercise_one]
		end
	end

	describe '.for_force_type' do
		it 'scopes the exercises with the specified force type' do
			force_type = create(:force_type)
			exercise_one = create(:exercise, force_type: force_type)
			exercise_two = create(:exercise, force_type: force_type)
			exercise_excluded = create(:exercise)

			expect(Exercise.for_force_type(force_type)).to eq [exercise_two, exercise_one]
		end
	end

	describe '.for_experience_level' do
		it 'scopes the exercises with the specified experience level' do
			experience_level = create(:experience_level)
			exercise = create(:exercise, experience_level: experience_level)
			exercise_two = create(:exercise, experience_level: experience_level)
			exercise_excluded = create(:exercise)

			expect(Exercise.for_experience_level(experience_level)).to eq [exercise_two, exercise]
		end
	end
end
