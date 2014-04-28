require 'spec_helper'

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
end
