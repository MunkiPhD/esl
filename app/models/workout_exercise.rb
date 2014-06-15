# == Schema Information
#
# Table name: workout_exercises
#
#  id          :integer          not null, primary key
#  workout_id  :integer          not null
#  exercise_id :integer          not null
#

class WorkoutExercise < ActiveRecord::Base
  belongs_to :workout, inverse_of: :workout_exercises
  belongs_to :exercise

  has_many :workout_sets, :dependent => :destroy, inverse_of: :workout_exercise

  validates :workout, presence: true
  validates :exercise, presence: true

  accepts_nested_attributes_for :workout_sets, allow_destroy: true, reject_if: :reject_workout_sets

	delegate :name, to: :exercise, prefix: true

  private
  def reject_workout_sets(attributes)
    attributes['rep_count'].blank? || attributes['weight'].blank?
  end
end
