require 'spec_helper'

describe WorkoutSet do
  describe "validations" do

    context "with valid data" do
      it "are valid for factory" do
        expect(build(:workout_set)).to be_valid
      end

      it "is valid with a workout" do
        expect(WorkoutSet.new(workout_id: 1)).to have(0).errors_on(:workout_id)
      end

      it "is valid with an exercise" do
        expect(WorkoutSet.new(exercise_id: 1)).to have(0).errors_on(:exercise_id)
      end
      pending "set number is greater than or equal to 1"
      pending "rep number must be greater than or equal to 0"
      pending "notes can be empty"
      pending "notes must be less than 250 characters"
    end

    context "with invalid data" do
      it "is invalid without a workout" do
        expect(WorkoutSet.new(workout_id: nil)).to have(1).errors_on(:workout_id)
      end

      pending "set number is zero"
      pending "rep number is less than zero"
      pending "notes is longer than 250 chars"
    end
  end
end
