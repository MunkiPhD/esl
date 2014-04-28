module FoodBlockDisplayHelper
	def macronutrient_summary_display(food)
		raw("<div class='summary-panel'><b>Calories: </b>#{food.calories}&nbsp;&nbsp;<b>Protein: </b>#{food.protein}g&nbsp;&nbsp;<b>Carbs: </b>#{food.carbs}g&nbsp;&nbsp;<b>Fat: </b>#{food.total_fat}g</div>")
	end
end
