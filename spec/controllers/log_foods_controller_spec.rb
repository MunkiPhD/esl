require 'spec_helper'

describe LogFoodsController do
  let(:user) { create(:user) }
  let(:logged_food){ create(:log_food, user: user) }

  before(:each) do
    sign_in user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', { food_id: logged_food.food } #path
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, { id: logged_food }
      response.should be_success
    end
  end


  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, { id: logged_food }
      response.should be_success
    end
  end

  describe "GET 'totals'" do
    render_views

    it 'returns correct json' do
      food = create(:food)
      date_str = format_date(Date.today)
      food_entry = create(:log_food, user: user, log_date: date_str, servings: 1.24, food: food)
      get 'daily_totals', date: date_str, format: "json"

      response.should be_success

      json = response.body
      parsed_response = JSON.parse(json) if json && json.length >= 2

      expect(parsed_response['protein']).to eq food_entry.protein
      expect(parsed_response['carbs']).to eq food_entry.carbs
      expect(parsed_response['fat']).to eq food_entry.total_fat
      expect(Date.parse(parsed_response['date'])).to eq food_entry.log_date
    end
  end

	describe "POST 'create' json" do
		render_views

		it 'creates the item and returns correct details' do
			food = create(:food)
			log_food = build(:log_food, user: user, food: food)
			post :create, { :format => 'json', :log_food => log_food.attributes, :food_id => food.id }
			puts response.body
			parsed_json = JSON.parse(response.body)
			expect(response.status).to eq 201
			expect(parsed_json["food_name"]).to eq food.name
			expect(parsed_json["log_food"]["servings"]).to eq sprintf("%.02f", log_food.servings)
		end

		it 'returns errors if missing attributes' do
			food = create(:food)
			post :create, { :format => 'json', :log_food => { trash: "test"}, :food_id => food.id}
			puts response.body
			expect(response.status).to eq 422
		end
	end
end
