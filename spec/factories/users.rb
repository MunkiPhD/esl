# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password                  "password"
    password_confirmation     "password"
    sequence(:email){ |n|     "user#{n}@email.com" }
    sequence(:username){ |n|  "username#{n}" }
  end
end
