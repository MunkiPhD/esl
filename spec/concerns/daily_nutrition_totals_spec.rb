require 'rails_helper'

describe DailyNutritionTotals do
	let(:user) { create(:user) }

	describe '#on_date' do
		it 'returns the sum of macronutrients' do
			date = Date.today
			logged_one = create(:log_food, user: user, log_date: date)
			logged_two = create(:log_food, user: user, log_date: date)		

			totals = DailyNutritionTotals.new(user).on_date(date)
			protein = logged_one.protein + logged_two.protein
			calories = logged_one.calories + logged_two.calories
			expect(totals.protein).to eq protein
			expect(totals.calories).to eq calories 
			expect(totals.date).to eq date
		end
	end

	describe '.calculate_totals' do
		it 'returns the sum of macronutrients' do
			date = Date.today
			logged_one = create(:log_food, user: user, log_date: date)
			logged_two = create(:log_food, user: user, log_date: date)		

			logged_foods = user.log_foods.on_date(date)
			totals = DailyNutritionTotals.sum_totals(logged_foods)

			protein = logged_one.protein + logged_two.protein
			carbs = logged_one.carbs + logged_two.carbs
			total_fat = logged_one.total_fat + logged_two.total_fat
			calories = logged_one.calories + logged_two.calories

			expect(totals.protein).to eq protein
			expect(totals.calories).to eq calories 
			expect(totals.carbs).to eq carbs
			expect(totals.total_fat).to eq total_fat
		end
	end
end
