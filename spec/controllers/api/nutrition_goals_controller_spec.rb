require 'rails_helper'

describe API::NutritionGoalsController, type: :controller do
	render_views

	let(:user) { create(:user) }

	before :each do
		sign_in user
	end

	after :each do
		LogFood.delete_all
	end


	describe 'GET index' do
		it 'returns http success' do
			get :index, format: "json"
			expect(response).to have_http_status(:success)
		end

		it 'has the nutrition goals for the user' do
			Timecop.freeze(Date.today) do
				log_food = create(:log_food, user: user, servings: 1)
				get :index, format: "json"

				parsed_json = JSON.parse(response.body)
				expect(parsed_json["nutrition_goals"]["calories"]).to eq user.nutrition_goal.calories
				expect(parsed_json["nutrition_goals"]["carbs"]).to eq user.nutrition_goal.carbs
				expect(parsed_json["nutrition_goals"]["protein"]).to eq user.nutrition_goal.protein
				expect(parsed_json["nutrition_goals"]["total_fat"]).to eq user.nutrition_goal.total_fat
			end
		end
	end
end
