class FavoriteFood < ActiveRecord::Base
  belongs_to :food
  belongs_to :user

  delegate :name, to: :food, prefix: true
end
