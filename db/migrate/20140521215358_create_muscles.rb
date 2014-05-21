class CreateMuscles < ActiveRecord::Migration
  def change
    create_table :muscles do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
