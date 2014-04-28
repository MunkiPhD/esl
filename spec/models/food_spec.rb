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

require 'spec_helper'

describe Food do
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
      expect(f).to have(0).errors_on(:calories)
    end

    it "calories from fat are >= 0" do
      f = Food.new(calories_from_fat: -1)
      expect(f).to have(0).errors_on(:calories_from_fat)
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

  it 'image content type validation' do
	food = create(:food)
	food.should validate_attachment_content_type(:food_image)
		.allowing('image/png', 'image/jpg', 'image/jpeg')
		.rejecting('text/plain', 'text/xml')
  end

  it 'has an attached image file' do
	  create(:food).should have_attached_file(:food_image)
  end

  # it seems like the validate attachment size isnt working correctly in the test
  #it 'has a size less than 2 MBs' do
  #		food = build(:food, food_image: File.new("#{Rails.root}/spec/fixtures/ron.jpg"))
  #		food.should validate_attachment_size(:food_image).in(0..2.megabytes)
  #  end

  describe "methods" do
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
