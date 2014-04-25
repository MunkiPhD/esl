require 'spec_helper'

describe OneRepMax do
	describe '#epley_formula' do
		it 'calculates the correct one rep max' do
			expect(OneRepMax.epley_formula(315, 10)).to eq 420
			expect(OneRepMax.epley_formula(315, 20)).to eq 525
			expect(OneRepMax.epley_formula(315, 21)).to eq 535.5
		end
	end

	describe '#brzycki_formula' do
		it 'calculates the corrent one rep max' do
			expect(OneRepMax.brzycki_formula(315, 10)).to eq 420
			expect(OneRepMax.brzycki_formula(315, 25)).to eq 945
			expect(OneRepMax.brzycki_formula(315, 21)).to eq 708.75
		end
	end
end
