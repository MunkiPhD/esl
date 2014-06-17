class CreateWorkoutTemplates < ActiveRecord::Migration
  def change
    create_table :workout_templates do |t|
			t.string :title, null: false
			t.text :notes, null: false, default: ""
			t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
