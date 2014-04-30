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
