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
