# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  password_salt          :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)      default(""), not null
#  height                 :decimal(4, 2)
#  gender                 :integer          default(0), not null
#  birth_date             :datetime
#

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
