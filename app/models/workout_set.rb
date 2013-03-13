class WorkoutSet < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise

  validates :workout_id, presence: true
  validates :set_number, presence: true,
                         allow_nil: false, 
                         numericality: { greater_than_or_equal_to: 1, only_integer: true } 
  validates :rep_count, presence: true, 
                        numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :notes, length: { maximum: 250 }
end
