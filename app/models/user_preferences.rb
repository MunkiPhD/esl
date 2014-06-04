class UserPreferences < ActiveRecord::Base
	belongs_to :user

	validates :default_system_id, presence: true
	validates :user, presence: true

	def weight_unit
		Unit.for_unit_system(self.default_system_id).for_unit_type(:weight).first
	end
end
