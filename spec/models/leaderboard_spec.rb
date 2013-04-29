require 'spec_helper'

describe Leaderboard do
  let(:user) { create(:user) }
  let(:circle) { create(:circle) }

  describe 'scopes' do
    describe '#max_weight' do
      it 'gets the workout with the highest weight recorded' do
        workout = create(:workout_with_exercises, user: user)
        workout2 = create(:workout_with_exercises, user: user)

        workout.workout_exercises[0].workout_sets[0].weight = 200
        workout.save
        workout2.workout_exercises[0].workout_sets[0].weight = 100
        workout2.save

        circle.add_member(user)

        user2 = create(:user)
        workout3 = create(:workout_with_exercises, user: user2)
        workout4 = create(:workout_with_exercises, user: user2)

        workout3.workout_exercises[0].workout_sets[0].weight = 300
        workout3.save
        workout4.workout_exercises[0].workout_sets[0].weight = 400
        workout4.save

        workouts = Leaderboard.circle_member_workouts(circle).max_weight

        expect(workouts).to eq [workout, workout4]
      end
    end
  end

  describe 'methods' do
    describe '#circle_member_workouts' do
      it 'gets the workouts for the users in the specified circle' do
        workout1 = create(:workout, user: user)
        workout2 = create(:workout, user: user)

        user2 = create(:user)
        workout3 = create(:workout, user: user2)

        circle.add_member(user)
        circle.add_member(user2)

        workouts = Leaderboard.circle_member_workouts(circle)
        expect(workouts).to eq [workout1, workout2, workout3]
      end
    end
  end

end
