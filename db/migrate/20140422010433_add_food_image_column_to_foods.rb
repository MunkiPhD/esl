class AddFoodImageColumnToFoods < ActiveRecord::Migration
	def self.up
		add_attachment :foods, :food_image
	end

	def self.down
		remove_attachment :foods, :food_image
	end
end
