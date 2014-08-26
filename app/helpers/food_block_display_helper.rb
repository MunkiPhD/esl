module FoodBlockDisplayHelper
	def macronutrient_summary_display(food)
		raw("<div class='summary-panel'><b>Calories: </b>#{number_with_precision(food.calories, :precision => 0, :significant => false, :strip_insignificant_zeroes => true)}&nbsp;&nbsp;<b>Protein: </b>#{number_with_precision(food.protein, :precision => 1, :significant => false, :strip_insignificant_zeroes => true)}g&nbsp;&nbsp;<b>Carbs: </b>#{number_with_precision(food.carbs, :precision => 1, :significant => false, :strip_insignificant_zeroes => true)}g&nbsp;&nbsp;<b>Fat: </b>#{number_with_precision(food.total_fat, :precision => 1, :significant => false, :strip_insignificant_zeroes => true)}g</div>")
	end
end
