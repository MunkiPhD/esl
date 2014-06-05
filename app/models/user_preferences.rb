class UserPreferences < ActiveRecord::Base
	belongs_to :user

	validates :default_system_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
	validates :user, presence: true

	def weight_unit
		Unit.for_unit_system(self.default_system_id).for_unit_type(:weight).first
	end

	def unit_system
		Unit.for_unit_system(self.default_system_id).first.unit_system_name
	end
end
