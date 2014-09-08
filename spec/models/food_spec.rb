# == Schema Information
#
# Table name: foods
#
#  id                      :integer          not null, primary key
#  name                    :string(255)      default("")
#  brand                   :string(255)      default("")
#  ndb_no                  :string(6)        default("")
#  ingredients             :text             default("")
#  usda                    :boolean          default(FALSE)
#  serving_size            :string(255)      default("1 serving"), not null
#  calories                :integer          default(0), not null
#  calories_from_fat       :integer          default(0), not null
#  total_fat               :decimal(, )      default(0.0), not null
#  saturated_fat           :decimal(, )      default(0.0), not null
#  trans_fat               :decimal(, )      default(0.0), not null
#  polyunsaturated_fat     :decimal(, )      default(0.0), not null
#  monounsaturated_fat     :decimal(, )      default(0.0), not null
#  cholesterol             :decimal(, )      default(0.0), not null
#  sodium                  :decimal(, )      default(0.0), not null
#  carbs                   :decimal(, )      default(0.0), not null
#  dietary_fiber           :decimal(, )      default(0.0), not null
#  sugars                  :decimal(, )      default(0.0), not null
#  protein                 :decimal(, )      default(0.0), not null
#  vitamin_a               :integer          default(0), not null
#  vitamin_c               :integer          default(0), not null
#  calcium                 :integer          default(0), not null
#  iron                    :integer          default(0), not null
#  vitamin_d               :integer          default(0), not null
#  vitamin_e               :integer          default(0), not null
#  vitamin_k               :integer          default(0), not null
#  thiamin                 :integer          default(0), not null
#  riboflavin              :integer          default(0), not null
#  niacin                  :integer          default(0), not null
#  vitamin_b6              :integer          default(0), not null
#  biotin                  :integer          default(0), not null
#  pantothenic_acid        :integer          default(0), not null
#  phosphorus              :integer          default(0), not null
#  iodine                  :integer          default(0), not null
#  magnesium               :integer          default(0), not null
#  zinc                    :integer          default(0), not null
#  selenium                :integer          default(0), not null
#  copper                  :integer          default(0), not null
#  manganese               :integer          default(0), not null
#  chromium                :integer          default(0), not null
#  molybednum              :integer          default(0), not null
#  caffeine                :integer          default(0), not null
#  alcohol                 :integer          default(0), not null
#  potassium               :decimal(, )      default(0.0), not null
#  folic_acid              :integer          default(0), not null
#  boron                   :decimal(, )      default(0.0), not null
#  decimal                 :decimal(, )      default(0.0), not null
#  cobalt                  :decimal(, )      default(0.0), not null
#  chloride                :decimal(, )      default(0.0), not null
#  fluoride                :decimal(, )      default(0.0), not null
#  acetic_acid             :decimal(, )      default(0.0), not null
#  citric_acid             :decimal(, )      default(0.0), not null
#  lactic_acid             :decimal(, )      default(0.0), not null
#  malic_acid              :decimal(, )      default(0.0), not null
#  choline                 :decimal(, )      default(0.0), not null
#  taurine                 :decimal(, )      default(0.0), not null
#  glutamine               :decimal(, )      default(0.0), not null
#  creatine                :decimal(, )      default(0.0), not null
#  sugar_alcohols          :decimal(, )      default(0.0), not null
#  created_at              :datetime
#  updated_at              :datetime
#  food_image_file_name    :string(255)
#  food_image_content_type :string(255)
#  food_image_file_size    :integer
#  food_image_updated_at   :datetime
#

require 'rails_helper'

describe Food do
	it_behaves_like 'nice urls' do
		let(:model) { create(:food, name: "Chicken breast asdso } pudding") }
	end

	describe 'callbacks' do
		describe 'before_validation' do
			it 'calculates the correct number of calories based on macronutrients' do
					food = build(:food, protein: 2, total_fat: 2, carbs: 2)
					food.valid?
					total_calories = (food.protein * 4 + food.carbs * 4 + food.total_fat * 9)
					expect(food.calories).to eq total_calories
					expect(food.calories_from_fat).to eq (food.total_fat * 9)
			end
		end
	end

  describe "validations" do
		it 'cannot have a blank name' do
			food = Food.new(name: nil)
			food.valid?
			expect(food.errors[:name]).to include "can't be blank"
		end

		it 'name cannot be less than two characters' do
			food = Food.new(name: "a")
			food.valid?
			expect(food.errors[:name]).to include "is too short (minimum is 2 characters)"
		end

    it "name can be two characters" do
			food = Food.new(name: "AB")
			food.valid?
      expect(food.errors[:name]).to eq []
    end

		it 'cannot have a name larger than 220 characters' do
			food = Food.new(name: ("a"*221))
			food.valid?
			expect(food.errors[:name]).to include "is too long (maximum is 220 characters)"
		end

    it "serving size cant be blank" do
      food = Food.new(serving_size: "")
			food.valid?
      expect(food.errors[:serving_size]).to include "can't be blank"
    end

    it "default serving size is '1 serving'" do
      f = Food.new()
      expect(f.serving_size).to eq "1 serving"
    end

    it "has a serving size less than 150 characters" do
      food = Food.new(serving_size: ("A" * 151))
			food.valid?
      expect(food.errors[:serving_size]).to include "is too long (maximum is 150 characters)"
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
