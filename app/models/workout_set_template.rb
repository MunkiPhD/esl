class WorkoutSetTemplate < ActiveRecord::Base
	belongs_to :workout_exercise_template, inverse_of: :workout_set_templates
  belongs_to :workout_template, inverse_of: :workout_set_templates
  belongs_to :exercise, inverse_of: :workout_set_tempaltes

  validates_presence_of :workout_template, :message => " !missing workout template id in workoutset" 
  validates_presence_of :exercise, :message => " !missing exercise id in workoutset"

	scope :for_exercise, -> (exercise) { where("workout_set_templates.exercise_id = ?", exercise) }
	scope :by_weight_desc, -> { order("workout_set_templates.weight DESC") }

  validates :workout_exercise_template, presence: true
  validates :notes, length: { maximum: 250 }
  validates :set_number, presence: true,
                         allow_nil: false, 
                         numericality: { greater_than_or_equal_to: 1, only_integer: true } 
  validates :rep_count, presence: true, 
                        numericality: { greater_than_or_equal_to: 0, only_integer: true }

  delegate :name, to: :exercise, prefix: true
end
