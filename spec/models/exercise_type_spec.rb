# == Schema Information
#
# Table name: exercise_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe ExerciseType do
	describe 'validations' do
		it 'must have a non-blank name' do
			expect(ExerciseType.new(name: '')).to have(1).errors_on(:name)
			expect(ExerciseType.new(name: nil)).to have(1).errors_on(:name)
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:exercise_type, name: "olympic WeighLifting") }
	end
end
