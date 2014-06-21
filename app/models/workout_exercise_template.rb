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

	def self.from_workout_exercise(workout_exercise)
		templ = WorkoutExerciseTemplate.new
		templ.exercise = workout_exercise.exercise
		workout_exercise.workout_sets.each do |ws|
			templ.workout_set_templates << WorkoutSetTemplate.from_workout_set(ws)
		end
		templ
	end
end
