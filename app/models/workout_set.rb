# == Schema Information
#
# Table name: workout_sets
#
#  id                  :integer          not null, primary key
#  set_number          :integer          not null
#  rep_count           :integer          not null
#  weight              :integer          not null
#  notes               :string(255)      default(""), not null
#  workout_exercise_id :integer          not null
#  created_at          :datetime
#  updated_at          :datetime
#  exercise_id         :integer          not null
#  workout_id          :integer          not null
#

class WorkoutSet < ActiveRecord::Base
  belongs_to :workout_exercise, inverse_of: :workout_sets
  belongs_to :workout, inverse_of: :workout_sets
  belongs_to :exercise, inverse_of: :workout_sets

  validates_presence_of :workout, :message => " !missing workout id in workoutset" 
  validates_presence_of :exercise, :message => " !missing exercise id in workoutset"

	scope :for_exercise, -> (exercise) { where("workout_sets.exercise_id = ?", exercise) }
	scope :by_weight_desc, -> { order("workout_sets.weight DESC") }

  validates :workout_exercise, presence: true
  validates :notes, length: { maximum: 250 }
  validates :set_number, presence: true,
                         allow_nil: false, 
                         numericality: { greater_than_or_equal_to: 1, only_integer: true } 
  validates :rep_count, presence: true, 
                        numericality: { greater_than_or_equal_to: 0, only_integer: true }

  delegate :name, to: :exercise, prefix: true


  def self.from_template(workout_set_template)
	  workout_set = WorkoutSet.new
	  workout_set.set_number = workout_set_template.set_number
	  workout_set.rep_count = workout_set_template.rep_count
	  workout_set.weight = get_correct_weight(workout_set_template)
	  workout_set.exercise = workout_set_template.exercise
	  workout_set
  end

  private

  def self.get_correct_weight(workout_set_template)
	  if workout_set_template.is_percent_of_one_rep_max
			0
	  else
		  workout_set_template.weight
	  end
  end
end
