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

FactoryGirl.define do
	factory :unit do
		unit_system			0
		unit_system_name	"US"
		unit_type			4
		unit_type_name		"weight"		
		unit_name			"pounds"
		unit_abbr			"lbs"
	end

	factory :unit_measurements, class: Unit do
		unit_system			0
		unit_system_name	"US"
		unit_type			5
		unit_type_name		"measurement"		
		unit_name			"inches"
		unit_abbr			"in"
	end
end
