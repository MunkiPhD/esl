# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log_food do
    servings "9.99"
    log_date "2014-04-10"
    user
    bread
  end
end
