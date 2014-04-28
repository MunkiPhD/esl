class DailyNutritionTotals
	def initialize(user)
		@user = user
	end

	def on_date(date)
		results = @user.log_foods.on_date(date)
		totals = calculate_totals(results)
		totals.date = date
		return totals
	end

	private 
	def calculate_totals(results)
		tots = OpenStruct.new(calories: 0, protein: 0, total_fat: 0, carbs: 0 )
		results.each do |result|
			tots.calories += result.calories
			tots.protein += result.protein
			tots.total_fat += result.total_fat
			tots.carbs += result.carbs
		end

		tots
	end
end
