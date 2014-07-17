module BodyMeasurementHelper
	def measurement_display(body_measurement, attr_symbol)
		if body_measurement[attr_symbol].blank?
			"#{attr_symbol.to_s.humanize}: <span class='not-measured'>not measured</span>".html_safe
		else
			"#{attr_symbol.to_s.humanize}: #{body_measurement[attr_symbol]} #{body_measurement.unit_abbr}"
		end
	end
end
