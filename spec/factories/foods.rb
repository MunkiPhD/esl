# == Schema Information
#
# Table name: foods
#
#  id                  :integer          not null, primary key
#  name                :string(255)      default("")
#  brand               :string(255)      default("")
#  ndb_no              :string(6)        default("")
#  ingredients         :text             default("")
#  usda                :boolean          default(FALSE)
#  serving_size        :string(255)      default("1 serving"), not null
#  calories            :integer          default(0), not null
#  calories_from_fat   :integer          default(0), not null
#  total_fat           :decimal(, )      default(0.0), not null
#  saturated_fat       :decimal(, )      default(0.0), not null
#  trans_fat           :decimal(, )      default(0.0), not null
#  polyunsaturated_fat :decimal(, )      default(0.0), not null
#  monounsaturated_fat :decimal(, )      default(0.0), not null
#  cholesterol         :decimal(, )      default(0.0), not null
#  sodium              :decimal(, )      default(0.0), not null
#  carbs               :decimal(, )      default(0.0), not null
#  dietary_fiber       :decimal(, )      default(0.0), not null
#  sugars              :decimal(, )      default(0.0), not null
#  protein             :decimal(, )      default(0.0), not null
#  vitamin_a           :integer          default(0), not null
#  vitamin_c           :integer          default(0), not null
#  calcium             :integer          default(0), not null
#  iron                :integer          default(0), not null
#  vitamin_d           :integer          default(0), not null
#  vitamin_e           :integer          default(0), not null
#  vitamin_k           :integer          default(0), not null
#  thiamin             :integer          default(0), not null
#  riboflavin          :integer          default(0), not null
#  niacin              :integer          default(0), not null
#  vitamin_b6          :integer          default(0), not null
#  biotin              :integer          default(0), not null
#  pantothenic_acid    :integer          default(0), not null
#  phosphorus          :integer          default(0), not null
#  iodine              :integer          default(0), not null
#  magnesium           :integer          default(0), not null
#  zinc                :integer          default(0), not null
#  selenium            :integer          default(0), not null
#  copper              :integer          default(0), not null
#  manganese           :integer          default(0), not null
#  chromium            :integer          default(0), not null
#  molybednum          :integer          default(0), not null
#  caffeine            :integer          default(0), not null
#  alcohol             :integer          default(0), not null
#  potassium           :decimal(, )      default(0.0), not null
#  folic_acid          :integer          default(0), not null
#  boron               :decimal(, )      default(0.0), not null
#  decimal             :decimal(, )      default(0.0), not null
#  cobalt              :decimal(, )      default(0.0), not null
#  chloride            :decimal(, )      default(0.0), not null
#  fluoride            :decimal(, )      default(0.0), not null
#  acetic_acid         :decimal(, )      default(0.0), not null
#  citric_acid         :decimal(, )      default(0.0), not null
#  lactic_acid         :decimal(, )      default(0.0), not null
#  malic_acid          :decimal(, )      default(0.0), not null
#  choline             :decimal(, )      default(0.0), not null
#  taurine             :decimal(, )      default(0.0), not null
#  glutamine           :decimal(, )      default(0.0), not null
#  creatine            :decimal(, )      default(0.0), not null
#  sugar_alcohols      :decimal(, )      default(0.0), not null
#  created_at          :datetime
#  updated_at          :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :food do
    name "Chicken Breast"
  end

  factory :ice_cream, class: Food do
    name "Chocolate Trinity"
    brand "Publix"
    calories "160"
    carbs "25"
    protein "3"
  end

  factory :bread, class: Food do
    name "100% Wheat Bread"
    serving_size "1 slice"
    brand "Wonder"
    calories "110"
    carbs "15"
  end
end
