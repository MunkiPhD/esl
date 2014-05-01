module NutritionGoalHelper
	def render_entry_row(macro_totals, nutrition_goal, field, display_unit)
		percent = calculate_percent(macro_totals.send(field), nutrition_goal.send(field)).to_i
		my_css_class = "progress-bar-#{get_correct_css(percent)}"
		display_unit_value = display_unit unless display_unit.include? 'kCal'

		return OpenStruct.new(percent: percent, css_class: my_css_class, 
									 field: field, 
									 macro_totals: macro_totals, 
									 nutrition_goal: nutrition_goal, 
									 display_unit_value:	 display_unit_value, 
									 display_unit_measurement: display_unit)
	end


	def protein_in_grams_to_percentage(protein_in_grams, total_calories)
		(((protein_in_grams.to_f * 4) / total_calories.to_f) * 100)
	end

	def carbs_in_grams_to_percentage(carbs_in_grams, total_calories)
		(((carbs_in_grams.to_f * 4) / total_calories.to_f) * 100)
	end

	def total_fat_in_grams_to_percentage(total_fat_in_grams, total_calories)
		(((total_fat_in_grams.to_f * 9) / total_calories.to_f) * 100)
	end

	private
	def calculate_percent(macro_total, nutrition_goal)
		if nutrition_goal <= 0 
			return ( 100 + macro_total )
		else
			return ((macro_total / nutrition_goal) * 100)
		end
	end

	def get_correct_css(percent)
		return 'danger' if percent <= 84
		return 'warning' if percent <= 94
		return 'success' if percent <= 104
		return 'warning' if percent <= 109
		return 'danger'	if percent >= 110
	end
end
