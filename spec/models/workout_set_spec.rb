# == Schema Information
#
# Table name: workout_sets
#
#  id                  :integer          not null, primary key
#  set_number          :integer          not null
#  rep_count           :integer          not null
#  weight              :integer          not null
#  notes               :string(255)      default(""), not null
#  workout_exercise_id :integer          not null
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe WorkoutSet do
  describe "validations" do

    context "with valid data" do
      it "are valid for factory" do
        expect(build(:workout_set)).to be_valid
      end

      it "is valid with a workout exercise" do
        expect(WorkoutSet.new(workout_exercise_id: 1)).to have(0).errors_on(:workout_exercise_id)
      end

      it "set number is greater than or equal to 1" do
        expect(WorkoutSet.new(set_number: 1)).to have(0).errors_on(:set_number)
      end

      it "rep number must be greater than or equal to 0" do
        expect(WorkoutSet.new(rep_count: 0)).to have(0).errors_on(:rep_count)
      end

      it "notes can be empty" do
        expect(WorkoutSet.new(notes:nil)).to have(0).errors_on(:notes)
      end

      it "notes must be less than 250 characters" do
        expect(WorkoutSet.new(notes: "a"*250)).to have(0).errors_on(:notes)
      end
    end

    context "is invalid if" do
      it "without a workout exercise when saving" do
        expect {
          build(:workout_set, workout_exercise_id: nil).save
        }.to change(WorkoutSet, :count).by(0)
        #expect(WorkoutSet.new(workout_exercise_id: nil).save).to have(1).errors_on(:workout_exercise_id)
      end


      it "set number is null" do
        expect(WorkoutSet.new(set_number: nil)).to have(2).errors_on(:set_number)
      end

      it "rep number is null" do
        expect(WorkoutSet.new(rep_count: nil)).to have(2).errors_on(:rep_count)
      end

      it "set number is zero" do
        expect(WorkoutSet.new(set_number: 0)).to have(1).errors_on(:set_number)
      end

      it "rep number is less than zero" do
        expect(WorkoutSet.new(rep_count:-1)).to have(1).errors_on(:rep_count)
      end

      it "notes is longer than 250 chars" do
        expect(WorkoutSet.new(notes: "1" * 251)).to have(1).errors_on(:notes)
      end

      it "only accepts whole numbers for sets" do
        expect(WorkoutSet.new(set_number: 1.1)).to have(1).errors_on(:set_number)
      end

      it "only accepts whole numbers for rep_count" do
        expect(WorkoutSet.new(rep_count: 1.1)).to have(1).errors_on(:rep_count)
      end

    end
  end
end
