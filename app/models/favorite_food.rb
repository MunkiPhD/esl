class FavoriteFood < ActiveRecord::Base
  belongs_to :food
  belongs_to :user

  delegate :name, to: :food, prefix: true

  scope :for_food, -> (food) { where("food_id = ?", food) } 
end
