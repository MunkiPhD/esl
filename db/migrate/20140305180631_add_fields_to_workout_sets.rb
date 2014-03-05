class AddFieldsToWorkoutSets < ActiveRecord::Migration
  def change
    add_column :workout_sets, :exercise_id, :integer, null: false
    add_column :workout_sets, :workout_id, :integer, null: false

    add_index :workout_sets, :exercise_id
    add_index :workout_sets, :workout_id
  end
end
