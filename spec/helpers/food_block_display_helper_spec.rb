require 'spec_helper'

describe FoodBlockDisplayHelper do
	describe '.macronutrient_summary_display' do
		it 'returns correct html' do
			food = Food.new(calories: 100, protein: 10, carbs: 11, total_fat: 12)
			result = macronutrient_summary_display(food)
			expect(result).to eq "<div class='summary-panel'><b>Calories:</b>100 <b>Protein:</b>10.0g <b>Carbs:</b>11.0g <b>Fat:</b>12.0g</div>"
		end
	end
end
