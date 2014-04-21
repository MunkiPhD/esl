module FoodBlockDisplayHelper
	def macronutrient_summary_display(food)
		raw("<div class='summary-panel'><b>Calories:</b>#{food.calories} <b>Protein:</b>#{food.protein}g <b>Carbs:</b>#{food.carbs}g <b>Fat:</b>#{food.total_fat}g</div>")
	end
end
