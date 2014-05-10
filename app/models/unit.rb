# == Schema Information
#
# Table name: units
#
#  id               :integer          not null, primary key
#  unit_type        :integer          not null
#  unit_type_name   :string(255)      not null
#  unit_system      :integer          not null
#  unit_system_name :string(255)      not null
#  unit_name        :string(255)      not null
#  unit_abbr        :string(255)      not null
#

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

		enum unit_system: { us_system: 0, metric_system: 1}

		scope :for_system, -> (system) { where(unit_system: system) }
		scope :for_unit, -> (unit_type) { where(unit_type: unit_type) }
end
