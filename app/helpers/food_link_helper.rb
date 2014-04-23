module FoodLinkHelper
	def link_to_log_food(food)
		link_to_add "Log Item", new_food_log_food_path(food),
		 	{ class: 'link-to-log-food', 
				data: { id: food.id, url: food_log_foods_path(food)  } 
			}
	end
end
