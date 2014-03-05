# == Schema Information
#
# Table name: circles
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  motto       :string(255)      default("")
#  description :text             default(""), not null
#  is_public   :boolean          default(TRUE), not null
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :circle do
    sequence(:name) { |n| "Tampa Powerlifting#{n}" }
    motto           "Lift Heavy."
    description     "Train hard, compete"
    is_public       true
    user
  end
end
