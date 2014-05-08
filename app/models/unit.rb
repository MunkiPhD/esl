class Unit < ActiveRecord::Base
	enum unit_type: { 
		duration: 0, 
		distance: 1, 
		elevation: 2, 
		height: 3, 
		weight: 4, 
		measurements: 5, 
		liquids: 6, 
		blood_glucose: 7 }
	enum unit_system: { us: 0, metric: 1}

	before_save :before_save_callback
	before_validation :before_save_callback

	private

	def before_save_callback
		throw 'You cannot modify a unit entry'
	end
end
