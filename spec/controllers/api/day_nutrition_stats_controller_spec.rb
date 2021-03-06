require 'rails_helper'

describe API::DayNutritionStatsController do
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
				food = create(:food, protein: 10, total_fat: 20, carbs: 30)
				log_date = 3.days.ago
				log_food = create(:log_food, user: user, servings: 2, log_date: log_date, food: food)

				get :index, { format: "json", log_date: { year: log_date.year, month: log_date.month, day: log_date.day }}

				parsed_json = JSON.parse(response.body)
				expect(parsed_json["daily_totals"]["calories"].to_i).to eq log_food.calories
				expect(parsed_json["daily_totals"]["protein"].to_i).to eq log_food.protein
				expect(parsed_json["daily_totals"]["total_fat"].to_i).to eq log_food.total_fat
				expect(parsed_json["daily_totals"]["carbs"].to_i).to eq log_food.carbs
				expect(parsed_json["log_date"]).to eq format_date(log_date)


				# issue a request to todays totals to make sure the previous test didnt get some other dates data
				today = Date.today

				get :index, { format: "json", log_date: { year: today.year, month: today.month, day: today.day }}

				parsed_json = JSON.parse(response.body)
				expect(parsed_json["daily_totals"]["calories"]).to eq 0
				expect(parsed_json["daily_totals"]["protein"]).to eq 0
				expect(parsed_json["daily_totals"]["total_fat"]).to eq 0
				expect(parsed_json["daily_totals"]["carbs"]).to eq 0
				expect(parsed_json["log_date"]).to eq format_date(today)
			end
		end
	end
end
