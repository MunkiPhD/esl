# == Schema Information
#
# Table name: foods
#
#  id          :integer          not null, primary key
#  name        :string(255)      default("")
#  brand       :string(255)      default("")
#  ndb_no      :string(6)        default("")
#  ingredients :text             default("")
#  usda        :boolean          default(FALSE)
#  decimal     :decimal(, )      default(0.0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Food do
  describe "validations" do
    it "has a name" do
      f = Food.new(name: nil)
      expect(f).to have(3).errors_on(:name)
    end

    it "has a name with at least two characters" do
      f = Food.new(name: "A")
      expect(f).to have(1).errors_on(:name)

      f.name = "AB"
      expect(f).to have(0).errors_on(:name)
    end

    it "has a name less than 150 characters" do
      f = Food.new(name: ("A"*151))
      expect(f).to have(1).errors_on(:name)

      f.name = ("A" * 150)
      expect(f).to have(0).errors_on(:name)
    end

    it "has a serving size that is not empty" do
      f = Food.new(serving_size: "")
      expect(f).to have(2).errors_on(:serving_size)
    end

    it "default serving size is '1 serving'" do
      f = Food.new()
      expect(f.serving_size).to eq "1 serving"
    end

    it "has a serving size less than 75 characters" do
      f = Food.new(serving_size: ("A" * 75))
      expect(f).to have(0).errors_on(:serving_size)

      f.serving_size = ("A" * 76)
      expect(f).to have(1).errors_on(:serving_size)
    end

    it "calories are >= 0" do
      f = Food.new(calories: -1)
      expect(f).to have(1).errors_on(:calories)
    end

    it "calories from fat are >= 0" do
      f = Food.new(calories_from_fat: -1)
      expect(f).to have(1).errors_on(:calories_from_fat)
    end

    it "total_fat are >= 0" do
      f = Food.new(total_fat: -1)
      expect(f).to have(1).errors_on(:total_fat)
    end
  end

  it "the ID param is {id}-{name}" do
    f = Food.create(name: "chicken breast")
    expect(f).to be_valid
    expect(f.to_param).to eq "#{f.id}-chicken-breast"
  end

  it '#find_by_param with the name' do
    f = Food.create(name: "chicken")
    found = Food.find_by_param(f.to_param)
    expect(f).to eq found
  end

  describe "methods" do
    it '#destroy does not delete item because it has been logged' do
      pending 'need to implement'
      logged_food = create(:eaten_bread)
      bread = Food.find(logged_food.food_id) # get the food item tied to the logged food
      
      expect(bread.destroy).to eq false # check that the food's destroy item returns false since it's already been logged
    end

    it "#destroy deletes the item" do
      food = create(:bread)
      food.destroy
      expect(food.destroyed?).to eq true
    end

    it "#search_for returns items with similar names" do
      food = create(:bread)
      list = Food.search_for(food.name)
      expect(list).to eq [food] 
    end

    it "#search_for will also return results that aren't in correct case" do
      food = create(:bread)
      list = Food.search_for(food.name.downcase)
      expect(list).to eq [food]
    end

    it "#search_for returns empty array if string is nil" do
      food = create(:bread)
      list = Food.search_for(nil)
      expect(list).to eq []
    end
  end
end
