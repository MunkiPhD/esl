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

require 'spec_helper'

describe Exercise do
  it "has a name" do
    exercise = Exercise.new
    user = User.new
    exercise.user_id = user
    expect(exercise).to_not be_valid
  end

  it "has a name at least three characters long" do
    exercise = Exercise.new
    exercise.user_id = 1
    exercise.name = "123"
    expect(exercise).to be_valid

    exercise.name = "12"
    expect(exercise).to_not be_valid
  end

  it "has a name that is less than 45 characters long" do
    exercise = Exercise.new(user_id:1)
    exercise.name = "1"*45
    expect(exercise).to be_valid
  end

  it "belongs to a user" do
    expect(build(:exercise, user_id: nil)).to have(1).errors_on(:user_id)
    expect(build(:exercise, user_id: 2)).to be_valid
    user = create(:user)
    exercise = user.exercises.build(name: "test")
    expect(exercise).to be_valid
  end
end
