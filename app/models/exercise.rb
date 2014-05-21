# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Exercise < ActiveRecord::Base
	belongs_to :muscle
  has_many :workout_exercises
  has_many :workout_sets, inverse_of: :exercise

  validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum:45}
  validates :user_id, presence: true

	def self.with_main_muscle(muscle)
		where(muscle: muscle)
	end
end
