module ProfileHelper
	def height(user)
		return "unknown" if user.height.nil?
		if user.preferences.default_system_id == MeasurementSystem::US_SYSTEM
			display_for_imperial(user.height)
		else
			display_for_metric(user.height)
		end
	end

	private
	def display_for_imperial(height)
		feet = height / 12
		inch = height % 12
		meters = height * 0.0254
		"#{feet.floor}' #{"%g" % inch}\" (#{number_with_precision(meters, precision: 2)} m)"
	end

	def display_for_metric(height)
		as_inches = (height * 0.3937)
		feet = as_inches / 12
		inch = as_inches % 12
		meters = height / 100
		"#{number_with_precision(meters, precision: 2)} m (#{feet.floor}' #{number_with_precision(inch, precision: 0)}\")"
	end
end
