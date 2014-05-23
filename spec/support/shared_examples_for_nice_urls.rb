require 'spec_helper'

shared_examples 'nice urls' do
	describe '#to_param' do
		it 'returns a nice url' do
			expect(model.to_param).to eq "#{model.id}-#{model.name.parameterize}"
		end
	end

	describe '.find_by_id' do
		it 'returns the correct exercise' do
			expect(described_class.find(model.to_param)).to eq model
		end
	end
end
