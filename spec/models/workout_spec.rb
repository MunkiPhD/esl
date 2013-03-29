# == Schema Information
#
# Table name: workouts
#
#  id             :integer          not null, primary key
#  title          :string(255)      not null
#  date_performed :date             not null
#  notes          :text             default(""), not null
#  user_id        :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Workout do
  describe "is valid with" do
    it "has a valid factory" do
      expect(build(:workout)).to be_valid
    end

    it "has a valid factory with exercises" do
      workout = build(:workout_with_exercises)
      expect(workout).to be_valid
    end

    it "builds the factory with the exercises and sets" do
      workout = build(:workout_with_exercises)
      expect(workout.workout_exercises.length).to eq(1)
      expect(workout.workout_exercises[0].workout_sets.length).to eq(3)
    end

    it "saves a workout with nested attributes" do
      workout = build(:workout_with_exercises)
      workout.save
      workout.reload
      expect(workout.workout_exercises.length).to eq(1)
      expect(workout.workout_exercises[0].workout_sets.length).to eq(3)
    end

    it "a title" do
      expect(Workout.new(title: "dsadas")).to have(0).errors_on(:title)  
    end

    it "a title less than 200 characters" do
      expect(Workout.new(title: "a" * 200)).to have(0).errors_on(:title)
    end
    
    it "a date performed" do
      expect(Workout.new(date_performed: DateTime.now)).to have(0).errors_on(:date_performed)
    end

    it "empty notes" do
      expect(Workout.new(notes: "")).to have(0).errors_on(:notes)
    end
    
    it "has a user" do
      expect(Workout.new(user_id: 1)).to have(0).errors_on(:user_id)
    end
  end

  describe "is in-valid with" do
    it "a title longer than 200 characters" do
      expect(Workout.new(title: "a" * 201)).to have(1).errors_on(:title)
    end

    it "no title" do
      expect(Workout.new(title: nil)).to have(2).errors_on(:title)
    end

    it "title less than 2 characters" do
      expect(Workout.new(title: "a")).to have(1).errors_on(:title)
    end

    it "no date date performed" do
      expect(Workout.new(date_performed: nil)).to have(1).errors_on(:date_performed)
    end

    it "no user" do
      expect(Workout.new(user_id: nil)).to have(1).errors_on(:user_id)
    end
  end
end
