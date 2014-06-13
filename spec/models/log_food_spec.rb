# == Schema Information
#
# Table name: log_foods
#
#  id         :integer          not null, primary key
#  servings   :decimal(, )      default(1.0), not null
#  log_date   :date             default(Thu, 29 May 2014), not null
#  food_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe LogFood do
  let(:user) { build(:user) }

  it 'responds to food_name' do
    bread = build(:bread)
    logged_food = LogFood.new(food: bread)
    expect(logged_food.food_name).to eq bread.name
  end

  describe ".on_date" do
    it 'returns the logged foods on specified date' do
			Timecop.freeze(Date.today - 1) do
				puts Date.today
				yesterday = create(:log_food, log_date: Date.today, user: user)
				expect(user.log_foods.on_date(Date.today)).to eq [yesterday]
			end
			Timecop.freeze(Date.today) do
				puts Date.today
				today = create(:log_food, log_date: Date.today, user: user)
				expect(user.log_foods.on_date(Date.today)).to eq [today]
			end
    end
  end

  describe ".for_food" do
    it 'returns the logged foods for the specified food' do
      food = create(:food)
      food2 = create(:food)
      logged = create(:log_food, food: food)
      expect(LogFood.for_food(food)).to eq [logged]
    end
  end


	describe '.latest' do
		it 'returns the logged foods by order of time logged, most recent first' do
			logged_first = create(:log_food, user: user, created_at: Time.now)
			logged_later = create(:log_food, user: user, created_at: (Time.now + 1.hour))
			expect(LogFood.latest).to eq [logged_later, logged_first]
		end
	end

  describe "#protein" do
    it 'it returns the correct amount of protein for the entry' do
      food = Food.new(protein: 2)
      log_entry = LogFood.new(food: food, servings: 2)
      expect(log_entry.protein).to eq 4
    end
  end

  describe "#carbs" do
    it 'returns the correct amount of carbs for the entry' do
      food = Food.new(carbs: 2)
      log_entry = LogFood.new(food: food, servings: 3)
      expect(log_entry.carbs).to eq 6
    end
  end

  describe "#total_fat" do
    it 'returns the correct amount of fat for the entry' do
      food = Food.new(total_fat: 2)
      log_entry = LogFood.new(food: food, servings: 2.5)
      expect(log_entry.total_fat).to eq 5
    end
  end

  describe "#total_calories" do
    it 'returns the calories based on macronutrients (fat)' do
      food = Food.new(total_fat: 2)
      log_entry = LogFood.new(food: food, servings: 2)
      expect(log_entry.calories).to eq 36
    end

    it 'returns the calories based on macronutrients (protein)' do
      food = Food.new(total_fat: 2, protein: 1, carbs: 2)
      log_entry = LogFood.new(food: food, servings: 1.2)
      expect(log_entry.calories).to eq ((9*2 + 4*1 + 4*2) * 1.2)
    end
  end

  context 'validation' do
    it 'has a valid factory' do
      expect(build(:log_food)).to be_valid
    end

    it 'has a user' do
      logged = LogFood.new(user: user)
			logged.valid?
			expect(logged.errors[:user]).to eq []
    end

    it 'has a food' do
      logged = LogFood.new(food: create(:bread))
			logged.valid?
			expect(logged.errors[:food]).to eq []
    end

    it 'has a date' do
      logged = LogFood.new
			logged.valid?
			expect(logged.errors[:log_date]).to eq []
    end

    it "must have a number greater than 0" do
      logged = LogFood.new(servings: 1.24)
			logged.valid?
			expect(logged.errors[:servings]).to eq []
    end
  end

  context "invalid" do
    it 'has a user' do
      logged = LogFood.new
			logged.valid?
			expect(logged.errors[:user]).to include "can't be blank"
    end

    it 'has a food' do
      logged = LogFood.new
			logged.valid?
			expect(logged.errors[:food]).to include "can't be blank"
    end

    it 'has a date' do
      logged = LogFood.new(log_date: "")
			logged.valid?
			expect(logged.errors[:log_date]).to include "can't be blank"
    end

    it "must have a number greater than 0" do
      logged = LogFood.new(servings: 0)
			logged.valid?
			expect(logged.errors[:servings]).to include 'must be greater than 0'
    end

    it 'has servings less than 1000' do
      logged = LogFood.new(servings: 1001)
			logged.valid?
			expect(logged.errors[:servings]).to include 'must be less than or equal to 1000'
    end
  end
end
