# == Schema Information
#
# Table name: workout_templates
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  notes      :text             default(""), not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class WorkoutTemplate < ActiveRecord::Base
	belongs_to :user

	validates :user_id, presence: true	

	def self.for_user(user)
		where(user: user)
	end

	def self.with_title(title)
		where(title: title)
	end

	private

end
