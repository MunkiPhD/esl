class CreateWorkoutSetTemplates < ActiveRecord::Migration
  def change
    create_table :workout_set_templates do |t|
      t.integer :set_number, null: false
      t.integer :rep_count, null: false
      t.integer :weight, null: false
      t.string :notes, null: false, default: ""
			t.boolean :is_percent_of_one_rep_max, null: false, default: false
			t.integer :percent_of_one_rep_max, null: false, default: 0
      t.references :workout_exercise_template, null: false

      t.timestamps
    end
  end
end
