json.log_date format_date(@presenter.current_date)

json.daily_totals do
	json.calories @presenter.macro_totals.calories
	json.protein @presenter.macro_totals.protein
	json.carbs @presenter.macro_totals.carbs
	json.total_fat @presenter.macro_totals.total_fat
end

json.nutrition_goals do 
	json.calories @presenter.nutrition_goal.calories
	json.protein @presenter.nutrition_goal.protein
	json.carbs @presenter.nutrition_goal.carbs
	json.total_fat @presenter.nutrition_goal.total_fat
end
