require 'spec_helper'

describe Muscle do
	describe 'validations' do
		it 'cannot have a blank name' do
			expect(Muscle.new(name: '')).to have(1).errors_on(:name)
			expect(Muscle.new(name: nil)).to have(1).errors_on(:name)
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:muscle) }
	end
end
