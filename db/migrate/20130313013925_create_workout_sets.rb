class CreateWorkoutSets < ActiveRecord::Migration
  def change
    create_table :workout_sets do |t|
      t.integer :set_number, null: false
      t.integer :rep_count, null: false
      t.integer :weight, null: false
      t.string :notes, null: false, default: ""
      t.references :workout_exercise, null: false

      t.timestamps
    end
  end
end
