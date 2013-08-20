class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :title, null: false
      t.date :date_performed, index: true, null: false
      t.text :notes, null: false, default: ""
      t.references :user, index: true, null:false

      t.timestamps
    end
  end
end
