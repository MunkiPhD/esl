class DailyNutritionTotals
	def initialize(user)
		@user = user
	end

	def on_date(date)
		results = @user.log_foods.on_date(date)
		totals = DailyNutritionTotals.sum_totals(results)
		totals.date = date
		return totals
	end

	def self.sum_totals(foods)
		tots = OpenStruct.new(calories: 0, protein: 0, total_fat: 0, carbs: 0 )
		foods.each do |food|
			tots.calories += food.calories
			tots.protein += food.protein
			tots.total_fat += food.total_fat
			tots.carbs += food.carbs
		end

		tots
	end
end
