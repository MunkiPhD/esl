# == Schema Information
#
# Table name: nutrition_goals
#
#  id         :integer          not null, primary key
#  calories   :integer          default(2000), not null
#  protein    :integer          default(50), not null
#  carbs      :integer          default(300), not null
#  total_fat  :integer          default(65), not null
#  user_id    :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe NutritionGoal do
	describe 'validations' do
		it 'has correct default values' do
			nutrition_goal = NutritionGoal.new
			expect(nutrition_goal.protein).to eq 50
			expect(nutrition_goal.carbs).to eq 300
			expect(nutrition_goal.total_fat).to eq 65
			expect(nutrition_goal.calories).to eq 2000
		end

		it 'sets calories at least to the mathematically correct value of the minimum of the macros' do
			nutrition_goal = NutritionGoal.new(calories: 5, protein: 1, carbs: 2, total_fat: 3, user: create(:user))
			expect(nutrition_goal.valid?).to eq true
			expect(nutrition_goal.calories).to eq 39
		end

		it 'can save calories that are higher than the minimum mathematical value based on macros' do
			nutrition_goal = NutritionGoal.new(calories: 1000, protein: 1, carbs: 2, total_fat: 3, user: create(:user))
			expect(nutrition_goal).to be_valid
		end
	end
end
