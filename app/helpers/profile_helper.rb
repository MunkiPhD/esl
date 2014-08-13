module ProfileHelper
	def height(inches)
		return "unknown" if inches.nil?
		feet = inches / 12
		inch = inches % 12
		meters = inches * 0.0254
		"#{feet.floor}' #{"%g" % inch}\" (#{number_with_precision(meters, precision: 2)} m)"
	end

	def age(dob)
		return "unknown" if dob.nil?
		today = Date.today
		age = today.year - dob.year
		age -= 1 if dob.strftime("%m%d").to_i > today.strftime("%m%d").to_i
		age
	end
end
