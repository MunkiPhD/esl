# == Schema Information
#
# Table name: workout_set_templates
#
#  id                           :integer          not null, primary key
#  set_number                   :integer          not null
#  rep_count                    :integer          not null
#  weight                       :integer          not null
#  notes                        :string(255)      default(""), not null
#  is_percent_of_one_rep_max    :boolean          default(FALSE), not null
#  percent_of_one_rep_max       :integer          default(0), not null
#  workout_exercise_template_id :integer          not null
#  created_at                   :datetime
#  updated_at                   :datetime
#

class WorkoutSetTemplate < ActiveRecord::Base
	belongs_to :workout_exercise_template, inverse_of: :workout_set_templates
	belongs_to :workout_template, inverse_of: :workout_set_templates
	belongs_to :exercise, inverse_of: :workout_set_templates

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
	validates :percent_of_one_rep_max, numericality: { greater_than: 0, only_integer: true }, if: :is_based_on_orm?


	delegate :name, to: :exercise, prefix: true


	def self.from_workout_set(workout_set)
		templ = WorkoutSetTemplate.new
		templ.set_number = workout_set.set_number
		templ.rep_count = workout_set.rep_count
		templ.weight = workout_set.weight
		templ.notes = workout_set.notes
		templ.exercise = workout_set.exercise
		templ
	end

	private
	def is_based_on_orm?
		is_percent_of_one_rep_max
	end
end
