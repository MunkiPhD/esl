class WorkoutSet < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise

  validates :workout_id, presence: true
end
