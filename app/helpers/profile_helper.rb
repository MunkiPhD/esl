module ProfileHelper
	def height(user)
		return "unknown" if user.height.nil?
		if user.preferences.default_system_id == MeasurementSystem::US_SYSTEM
			feet = user.height / 12
			inch = user.height % 12
			meters = user.height * 0.0254
			"#{feet.floor}' #{"%g" % inch}\" (#{number_with_precision(meters, precision: 2)} m)"
		else
			as_inches = (user.height * 0.3937)
			feet = as_inches / 12
			inch = as_inches % 12
			meters = user.height / 100
			"#{number_with_precision(meters, precision: 2)} m (#{feet.floor}' #{number_with_precision(inch, precision: 0)}\")"
		end
	end
end
