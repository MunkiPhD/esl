# == Schema Information
#
# Table name: favorite_foods
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  food_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe FavoriteFood do
  describe '#food_name' do
    it 'has the name of the food' do
      food = build(:food)
      favorite_food = FavoriteFood.new(food: food)
      expect(favorite_food.food_name).to eq food.name
    end
  end

  describe ".for_food" do
    it 'returns favorites for the specified id' do
      food = create(:food)
      food2 = create(:food)
      favorite_food = create(:favorite_food, food: food)
      favorite_food2 = create(:favorite_food, food: food2)

      expect(FavoriteFood.for_food(food)).to eq [favorite_food]
    end
  end


  describe "validation" do
    it "is unique for user/food pair" do
      food = create(:food)
      user = create(:user)
      existing_favorite = create(:favorite_food, food: food, user: user)
      new_favorite = build(:favorite_food, food: food, user: user)
      expect(new_favorite).to_not be_valid
    end
  end
end
