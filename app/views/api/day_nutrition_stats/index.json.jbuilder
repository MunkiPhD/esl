json.log_date format_date(@presenter.current_date)

json.daily_totals do
	json.calories @presenter.macro_totals.calories
	json.protein @presenter.macro_totals.protein
	json.carbs @presenter.macro_totals.carbs
	json.total_fat @presenter.macro_totals.total_fat
end
