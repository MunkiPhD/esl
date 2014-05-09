# == Schema Information
#
# Table name: nutrition_goals
#
#  id         :integer          not null, primary key
#  calories   :integer          default(2000), not null
#  protein    :integer          default(50), not null
#  carbs      :integer          default(300), not null
#  total_fat  :integer          default(65), not null
#  user_id    :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

class NutritionGoal < ActiveRecord::Base
	before_validation :set_calories

	belongs_to :user

	validates :calories, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20000 }
	validates :protein, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20000 }
	validates :carbs, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20000 }
	validates :total_fat, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20000 }
	validates :user, presence: true

	private
	def set_calories
		min_calories = (self.protein * 4) + (self.carbs * 4) + (self.total_fat * 9)
		self.calories = min_calories if self.calories < min_calories
	end
end
