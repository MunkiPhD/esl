class BodyWeight < ActiveRecord::Base
	belongs_to :user
	belongs_to :unit

	validates :weight, presence: true, numericality: {	only_integer: false,	greater_than: 0, less_than: 900 }
	validates :user, presence: true
	validates :unit, presence: true
end
