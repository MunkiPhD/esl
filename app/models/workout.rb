class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :workout_sets

  validates :title, presence: true, length: {minimum: 2, maximum: 200}
  validates :user_id, presence: true
  validates :date_performed, presence: true
  validates :notes, presence: true, allow_blank: true
end
