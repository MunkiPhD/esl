require 'spec_helper'

describe ExerciseType do
	describe 'validations' do
		it 'must have a non-blank name' do
			expect(ExerciseType.new(name: '')).to have(1).errors_on(:name)
			expect(ExerciseType.new(name: nil)).to have(1).errors_on(:name)
		end
	end
end
