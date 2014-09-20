json.nutrition_goals do 
	json.calories @nutrition_goals.calories
	json.protein @nutrition_goals.protein
	json.carbs @nutrition_goals.carbs
	json.total_fat @nutrition_goals.total_fat
end
