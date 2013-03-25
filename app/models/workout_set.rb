# == Schema Information
#
# Table name: workout_sets
#
#  id          :integer          not null, primary key
#  set_number  :integer          not null
#  rep_count   :integer          not null
#  weight      :integer          not null
#  notes       :string(255)      default(""), not null
#  workout_id  :integer          not null
#  exercise_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class WorkoutSet < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise

  # validates :workout_id, presence: true
  validates :exercise_id, presence: true
  validates :notes, length: { maximum: 250 }
  validates :set_number, presence: true,
                         allow_nil: false, 
                         numericality: { greater_than_or_equal_to: 1, only_integer: true } 
  validates :rep_count, presence: true, 
                        numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
