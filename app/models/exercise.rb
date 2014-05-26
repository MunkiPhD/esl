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
	include NiceUrl
	include ExerciseFilters

	belongs_to :muscle
	belongs_to :exercise_type
	belongs_to :equipment
	belongs_to :mechanic_type
	belongs_to :force_type
	belongs_to :experience_level
	has_many :workout_exercises
	has_many :workout_sets, inverse_of: :exercise

	serialize :instructions, Array

	validates :name, presence: true, uniqueness: true, length: {minimum: 3, maximum:60}
	validates :exercise_type, presence: true
	validates :equipment, presence: true
	validates :mechanic_type, presence: true
	validates :force_type, presence: true
	validates :experience_level, presence: true

	[:muscle, :exercise_type, :equipment, :mechanic_type, :force_type, :experience_level].each do |type|
		delegate :name, to: type, prefix: true
	end
end
