# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    # user.name                     "Test User"
    email                     "user@email.com"
    password                  "password"
    password_confirmation     "password"
  end
end
