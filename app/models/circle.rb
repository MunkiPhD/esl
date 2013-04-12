class Circle < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, 
                   uniqueness: true, 
                   length: { minimum: 3, maximum: 50 }
  validates :motto, length: { maximum: 50 }
  validates :user, presence: true
  validates :is_public, presence: true
end
