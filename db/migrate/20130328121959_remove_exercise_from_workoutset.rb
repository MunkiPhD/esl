class RemoveExerciseFromWorkoutset < ActiveRecord::Migration
  def change
    remove_column :workout_sets, :exercise_id
    remove_column :workout_sets, :workout_id
  end
end
