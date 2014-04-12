# == Schema Information
#
# Table name: log_foods
#
#  id         :integer          not null, primary key
#  servings   :decimal(, )      default(1.0), not null
#  log_date   :date             default(Thu, 10 Apr 2014), not null
#  food_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe LogFood do
  let(:user) { build(:user) }

  it 'responds to food_name' do
    bread = build(:bread)
    logged_food = LogFood.new(food: bread)
    expect(logged_food.food_name).to eq bread.name
  end

  describe "#on_date" do
    it 'returns the logged foods on specified date' do
      yesterday = create(:log_food, log_date: Date.yesterday, user: user)
      today = create(:log_food, log_date: Date.today, user: user)
      expect(user.log_foods.on_date(Date.today)).to eq [today]
      expect(user.log_foods.on_date(Date.yesterday)).to eq [yesterday]
    end
  end

  describe "#for_food" do
    it 'returns the logged foods for the specified food' do
      food = create(:food)
      food2 = create(:food)
      logged = create(:log_food, food: food)
      expect(LogFood.for_food(food)).to eq [logged]
    end
  end

  context 'validation' do
    it 'has a valid factory' do
      expect(build(:log_food)).to be_valid
    end

    it 'has a user' do
      logged = LogFood.new(user: user)
      expect(logged).to have(0).errors_on(:user)
    end

    it 'has a food' do
      logged = LogFood.new(food: create(:bread))
      expect(logged).to have(0).errors_on(:food)
    end

    it 'has a date' do
      logged = LogFood.new
      expect(logged).to have(0).errors_on(:log_date)
    end

    it "must have a number greater than 0" do
      logged = LogFood.new(servings: 1.24)
      expect(logged).to have(0).errors_on(:servings)
    end
  end

  context "invalid" do
    it 'has a user' do
      logged = LogFood.new
      expect(logged).to have(1).errors_on(:user)
    end

    it 'has a food' do
      logged = LogFood.new
      expect(logged).to have(1).errors_on(:food)
    end

    it 'has a date' do
      logged = LogFood.new(log_date: "")
      expect(logged).to have(1).errors_on(:log_date)
    end

    it "must have a number greater than 0" do
      logged = LogFood.new(servings: 0)
      expect(logged).to have(1).errors_on(:servings)
    end

    it 'has servings less than 1000' do
      logged = LogFood.new(servings: 1001)
      expect(logged).to have(1).errors_on(:servings)
    end
  end
end
