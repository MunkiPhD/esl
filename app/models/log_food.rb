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
end
