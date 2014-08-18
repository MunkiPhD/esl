require 'rails_helper'

describe ProfileHelper do
	describe '#height' do
		it 'displays a height in common format' do
			result = helper.height(70.to_f)
			expect(result).to eq "5' 10\" (1.78 m)"
		end

		it 'returns "unknown" if null' do
			result = helper.height(nil)
			expect(result).to eq "unknown"
		end
	end
end
