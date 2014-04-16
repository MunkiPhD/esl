require 'spec_helper'

describe FavoriteFood do
  describe '#food_name' do
    it 'has the name of the food' do
      food = build(:food)
      favorite_food = FavoriteFood.new(food: food)
      expect(favorite_food.food_name).to eq food.name
    end
  end
end
