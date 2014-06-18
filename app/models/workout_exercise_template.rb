class WorkoutExerciseTemplate < ActiveRecord::Base
	belongs_to :workout_template, inverse_of: :workout_exercise_templates
  belongs_to :exercise

  validates :workout_template, presence: true
  validates :exercise, presence: true
end
