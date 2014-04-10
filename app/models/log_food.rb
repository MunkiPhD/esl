class LogFood < ActiveRecord::Base
  belongs_to :user
  belongs_to :food

  validates :user, presence: true
  validates :food, presence: true
  validates :log_date, presence: true
  validates :servings, presence: true,
    numericality:  { greater_than: 0, less_than_or_equal_to: 1000 }
end
