class Exercise < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: {minimum: 3, maximum:45}
  validates :user_id, presence: true
end
