require 'spec_helper'

describe ForceType do
	describe 'validations' do
		it 'must have a non-blank name' do
			expect(ForceType.new(name: '')).to have(1).errors_on(:name)
			expect(ForceType.new(name: nil)).to have(1).errors_on(:name)
		end
	end

	it_behaves_like 'nice urls' do
		let(:model) { create(:force_type) }
	end
end
