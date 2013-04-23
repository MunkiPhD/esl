# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password                  "password"
    password_confirmation     "password"
    sequence(:email){ |n|     "user#{n}@email.com" }
    sequence(:username){ |n|  "username#{n}" }
  end

  factory :user_circle_member do
    after(:create) { |user| circle.add_member user }
  end

  factory :user_circle_admin do
    after(:create) do |user|
      circle = create(:circle)
      circle.add_admin user
    end #{ |user| user.grant :circle_admin, circle }
  end
end
