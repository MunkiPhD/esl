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
	include HasUnit

	before_save :before_save_callback
	before_validation :before_save_callback

	private

	def before_save_callback
		throw 'You cannot modify a unit entry'
	end
end
