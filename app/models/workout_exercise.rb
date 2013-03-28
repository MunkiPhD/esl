# == Schema Information
#
# Table name: workout_exercises
#
#  id          :integer          not null, primary key
#  workout_id  :integer          not null
#  exercise_id :integer          not null
#

class WorkoutExercise < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise

  has_many :workout_sets, :dependent => :destroy

  validates :workout_id, presence: true
  validates :exercise_id, presence: true


  accepts_nested_attributes_for :workout_sets, allow_destroy: true
end
