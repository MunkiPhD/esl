# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise do
    sequence(:name){ |n| "deadlift_#{n}" }
		equipment
		exercise_type
		experience_level
		force_type
		mechanic_type
		muscle
		instructions ['pick up weight', 'drop weight', 'get big']
  end

  factory :squat, class: Exercise do
    name "squat"
		alternate_name "barbell squat"
		equipment
		exercise_type
		experience_level
		force_type
		mechanic_type
		muscle
		instructions ['pick up weight', 'drop weight', 'get big', 'profit']
  end
end
