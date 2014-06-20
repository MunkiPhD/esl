# == Schema Information
#
# Table name: workout_exercise_templates
#
#  id                  :integer          not null, primary key
#  workout_template_id :integer          not null
#  exercise_id         :integer          not null
#

class WorkoutExerciseTemplate < ActiveRecord::Base
	belongs_to :workout_template, inverse_of: :workout_exercise_templates
	belongs_to :exercise

	has_many :workout_set_templates, :dependent => :destroy, inverse_of: :workout_exercise_template

	validates :workout_template, presence: true
	validates :exercise, presence: true
end
