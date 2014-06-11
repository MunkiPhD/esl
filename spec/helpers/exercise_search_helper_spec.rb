require 'rails_helper'

describe ExerciseSearchHelper do
	describe '.was_checked' do
		it 'returns true if the selection option was checked' do
			muscle = create(:muscle)
			helper.stub(:params).and_return({:muscles => ["#{muscle.id}"] })
			expect(helper.was_checked(:muscles, muscle)).to eq true
		end

		it 'returns false if the selection option was not checked' do
			muscle = create(:muscle)
			helper.stub(:params).and_return({:muscles => [] })
			expect(helper.was_checked(:muscles, muscle)).to eq false
		end

		it 'returns false if params is empty' do
			muscle = create(:muscle)
			helper.stub(:params).and_return({})
			expect(helper.was_checked(:muscles, muscle)).to eq false
		end
	end
end
