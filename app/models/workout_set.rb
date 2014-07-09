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


  def self.from_template(workout_set_template, user)
	  workout_set = WorkoutSet.new
	  workout_set.set_number = workout_set_template.set_number
	  workout_set.rep_count = workout_set_template.rep_count
	  workout_set.weight = get_weight_for_template(workout_set_template, user)
	  workout_set.exercise = workout_set_template.exercise
	  workout_set
  end

  private

  def self.get_weight_for_template(workout_set_template, user)
	  if workout_set_template.is_percent_of_one_rep_max
		  weight = get_logged_orm_weight_for_user(workout_set_template.exercise, user)
		  (weight * (workout_set_template.percent_of_one_rep_max.to_f / 100))
	  else
		  workout_set_template.weight
	  end
  end

  def self.get_logged_orm_weight_for_user(exercise, user)
	  result = WorkoutQueries.max_weight_for_exercise_and_user(exercise, user).first	
	  if result.nil? 
		  0
	  else
		  result.weight
	  end
  end
end
