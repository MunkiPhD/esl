class Food < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2, maximum: 150 }, allow_blank: false
  validates :serving_size, presence: true, length: { minimum: 1, maximum: 75 }
end
