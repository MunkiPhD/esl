require 'rails_helper'

describe ProfileHelper do
	describe '#height' do
		it 'displays a height in common format' do
			result = helper.height(70)
			expect(result).to eq "5'10\" (1.78 m)"
		end

		it 'returns "unknown" if null' do
			result = helper.height(nil)
			expect(result).to eq "unknown"
		end
	end

	describe '#age' do
		it 'displays "unknown" if date is null' do
			result = helper.age(nil)
			expect(result).to eq "unknown"
		end

		it 'displays the correct age based on a date' do
			Timecop.freeze(Date.new(2010, 4, 4)) do
				dob = Date.new(1976, 4, 10)
				result = helper.age(dob)
				expect(result).to eq 33
			end
		end

		it 'displays the correct age on a date 2' do 
			Timecop.freeze(Date.new(2010, 4, 14)) do
				dob = Date.new(1976, 4, 10)
				result = helper.age(dob)
				expect(result).to eq 34
			end
		end
	end
end
