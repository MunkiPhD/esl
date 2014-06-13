require 'rails_helper'

describe Muscle do
	it_behaves_like 'nice urls' do
		let(:model) { create(:muscle) }
	end

	describe 'validations' do
		it 'cannot have a blank name' do
			muscle = Muscle.new(name: '')
			muscle.valid?
			expect(muscle.errors[:name]).to include "can't be blank"
		end
	end
end
