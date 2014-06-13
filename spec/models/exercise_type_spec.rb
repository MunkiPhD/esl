# == Schema Information
#
# Table name: exercise_types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe ExerciseType do
	describe 'validations' do
		it 'must have a non-blank name' do
			exercise_type = ExerciseType.new(name: '')
			exercise_type.valid?
			expect(exercise_type.errors[:name]).to include "can't be blank"
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:exercise_type, name: "olympic WeighLifting") }
	end
end
