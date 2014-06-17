class WorkoutTemplate < ActiveRecord::Base
	before_save :set_name

	belongs_to :user

	validates :user_id, presence: true	

	def self.for_user(user)
		where(user: user)
	end

	private

	def set_name
		WorkoutTemplate.where("workout_template.user_id = ?", user_id)
	end
end
