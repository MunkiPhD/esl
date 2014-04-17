# == Schema Information
#
# Table name: favorite_foods
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  food_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class FavoriteFood < ActiveRecord::Base
  belongs_to :food
  belongs_to :user

  delegate :name, to: :food, prefix: true

  scope :for_food, -> (food) { where("food_id = ?", food) } 

  validates :user, uniqueness: { scope: :food }
end
