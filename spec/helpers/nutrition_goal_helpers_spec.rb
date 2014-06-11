require 'rails_helper'
describe NutritionGoalHelper do
	describe '#protein_in_grams_to_percentage' do
		it 'calculates correct percentage' do
			result = helper.protein_in_grams_to_percentage(10, 100)
			expect(result).to eq 40.0
		end
	end

	describe '#carbs_in_grams_to_percentage' do
		it 'calculates correct percentage' do
			result = helper.carbs_in_grams_to_percentage(12, 100)
			expect(result).to eq 48.0
		end
	end
	
	describe '#total_fat_in_grams_to_percentage' do
		it 'calculates correct percentage' do
			result = helper.total_fat_in_grams_to_percentage(10, 100)
			expect(result).to eq 90.0
		end
	end
end
