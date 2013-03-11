class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name, :null => false
      t.references :user, :null => false

      t.timestamps
    end
  end
end
