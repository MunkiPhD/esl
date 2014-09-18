require 'rails_helper'

describe API::NutritionGoalsController, type: :controller do
	render_views
	
	let(:user) { create(:user) }

	before :each do
		sign_in user
	end

	describe 'GET index' do
		it 'returns http success' do
			get :index, format: "json"
			expect(response).to have_http_status(:success)
		end


		it 'returns the info for the daily totals on todays date' do
			Timecop.freeze(Date.today) do
				log_food = create(:log_food, user: user, servings: 1)
				get :index, format: "json"

				parsed_json = JSON.parse(response.body)
				expect(parsed_json["daily_totals"]["calories"]).to eq log_food.calories
				expect(parsed_json["daily_totals"]["protein"]).to eq log_food.protein
				expect(parsed_json["daily_totals"]["total_fat"]).to eq log_food.total_fat
				expect(parsed_json["daily_totals"]["carbs"]).to eq log_food.carbs
			end
		end

		it 'returns the daily totals for the specified date' do
			Timecop.freeze(Date.today) do
				log_food = create(:log_food, user: user, servings: 2, log_date: 2.days.ago)
				p log_food.log_date
				get :index, { format: "json", selected_date: { year: 2.days.ago.year, month: 2.days.ago.month, day: 2.days.ago.day }}

				parsed_json = JSON.parse(response.body)
				expect(parsed_json["daily_totals"]["calories"]).to eq log_food.calories * 2
				expect(parsed_json["daily_totals"]["protein"]).to eq log_food.protein * 2
				expect(parsed_json["daily_totals"]["total_fat"]).to eq log_food.total_fat * 2
				expect(parsed_json["daily_totals"]["carbs"]).to eq log_food.carbs * 2
			end
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
