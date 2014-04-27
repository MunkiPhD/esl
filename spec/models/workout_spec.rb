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
  let(:user) { create(:user) }

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


  it ":date_desc fetches workouts based on date performed, latest first" do
    workout_one = create(:workout_with_exercises, user: user, date_performed: Date.today - 3) 
    workout_two = create(:workout_with_exercises, user: user, date_performed: Date.today - 1)
    workout_three = create(:workout_with_exercises, user: user, date_performed: Date.today - 2)
    expect(user.workouts.date_desc).to eq [workout_two, workout_three, workout_one]
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

  describe 'methods' do
    describe '#max_weight' do
      it "fetches an empty array for no exercise of type" do
        circle = create(:circle, user: user)
        workout = create(:workout_with_exercises, user: user)
        exercise = workout.workout_exercises[0].exercise
        circle.add_member user
        
        max_workouts = Leaderboard.max_weight_for_exercise_on_circle(circle, exercise)
        expect(max_workouts.blank?).to eq false

        max_workouts = Leaderboard.max_weight_for_exercise_on_circle(circle, create(:exercise))
        expect(max_workouts.blank?).to eq true
      end


      it 'fetches the workout with the highest weight' do
        workout = create(:workout_with_exercises, user: user)
        workout_1 = create(:workout_with_exercises, user: user)

        workout.workout_exercises[0].workout_sets[0].weight += 200
        workout.save

        exercise = workout.workout_exercises[0].exercise

        workout_1.workout_exercises[0].exercise = exercise
        workout_1.workout_exercises[0].workout_sets[0].weight += 100
        workout_1.save

        # a user that did the same exercise
        user2 = create(:user)
        workout2 = create(:workout_with_exercises, user: user2)
        workout2.workout_exercises[0].exercise = exercise
        workout2.workout_exercises[0].workout_sets[0].weight += 150
        workout2.save


        # a user that did a different exercise
        user3 = create(:user)
        exercise2 = create(:exercise)
        workout3 = create(:workout_with_exercises, user: user3)
        workout3.workout_exercises[0].exercise = exercise2
        workout3.workout_exercises[0].workout_sets[0].weight += 350
        workout3.save

        expect(exercise).to_not eq exercise2

        circle = create(:circle)
        circle.add_member user
        circle.add_member user2
        circle.add_member user3

        max_workouts = Leaderboard.max_weight_for_exercise_on_circle(circle, exercise)

        expect(max_workouts).to eq [workout, workout2]
      end
    end
  end
end
