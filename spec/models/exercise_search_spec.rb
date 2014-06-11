require 'rails_helper'

describe ExerciseSearch do
	describe '.filter' do
		it 'returns all exercises by default' do
			expect(ExerciseSearch.filter({})).to eq Exercise.order(name: :asc)
		end

		it 'returns exercises of types' do
			exercise_type = create(:exercise_type)
			exercise = create(:exercise, exercise_type: exercise_type)
			exercise_excluded = create(:exercise)
			expect(ExerciseSearch.filter({ exercise_types: [exercise_type.id]})).to eq [exercise]
		end

		it 'returns exercises with muscles' do
			muscle = create(:muscle)
			muscle_two = create(:muscle)
			exercise = create(:exercise, muscle: muscle)
			exercise_two = create(:exercise, muscle: muscle_two)
			exercise_excluded = create(:exercise)
			expect(ExerciseSearch.filter({ muscles: [muscle.id, muscle_two.id]})).to eq [exercise, exercise_two]
		end
	end
end
