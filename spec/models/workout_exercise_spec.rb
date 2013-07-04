# == Schema Information
#
# Table name: workout_exercises
#
#  id          :integer          not null, primary key
#  workout_id  :integer          not null
#  exercise_id :integer          not null
#

require 'spec_helper'

describe WorkoutExercise do
  context "validations" do
  it "has a valid factory" do
    expect(build(:workout_exercise)).to be_valid
  end

  it "has a workout" do
    expect(WorkoutExercise.new(workout_id: 1)).to have(0).errors_on(:workout_id)
  end

  it "has an exercise" do
    expect(WorkoutExercise.new(exercise_id: 1)).to have(0).errors_on(:exercise_id)
  end
  end

  context "in-valid data" do
    it "missing workout id will not save" do
      expect {
        build(:workout_exercise, workout_id: nil).save 
      }.to change(WorkoutExercise, :count).by(0)
    end

    it "missing exercise id will not save" do
      expect {
        build(:workout_exercise, exercise_id: nil).save 
      }.to change(WorkoutExercise, :count).by(0)
    end
  end
end
