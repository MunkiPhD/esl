# == Schema Information
#
# Table name: log_foods
#
#  id         :integer          not null, primary key
#  servings   :decimal(, )      default(1.0), not null
#  log_date   :date             default(Thu, 10 Apr 2014), not null
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

  scope :on_date, ->(date) { where("log_date = ?", date) }
  scope :for_food, ->(food) { where("food_id = ?", food) }

  def entry_protein
    return food.protein * servings
  end

  def entry_carbs
    return food.carbs * servings
  end

  def entry_fat
    return food.total_fat * servings
  end

  def total_calories
    (entry_protein * 4) + (entry_carbs * 4) + (entry_fat * 9)
  end
end
