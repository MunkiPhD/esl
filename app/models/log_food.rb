# == Schema Information
#
# Table name: log_foods
#
#  id         :integer          not null, primary key
#  servings   :decimal(, )      default(1.0), not null
#  log_date   :date             default(Thu, 29 May 2014), not null
#  food_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class LogFood < ActiveRecord::Base
  belongs_to :user
  belongs_to :food

  validates :user, presence: true
  validates :food, presence: true
  validates :log_date, presence: true
  validates :servings, presence: true,
    numericality:  { greater_than: 0, less_than_or_equal_to: 1000 }

  delegate :name, to: :food, prefix: true

  scope :on_date, ->(date) { where("log_foods.log_date = ?", date) }
  scope :for_food, ->(food) { where("log_foods.food_id = ?", food) }
  scope :latest, -> { order(created_at: :desc) }

  def protein
    return food.protein * servings
  end

  def carbs
    return food.carbs * servings
  end

  def total_fat
    return food.total_fat * servings
  end

  def calories
    (protein * 4) + (carbs * 4) + (total_fat * 9)
  end
end
