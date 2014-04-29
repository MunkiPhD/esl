class CreateNutritionGoals < ActiveRecord::Migration
  def change
    create_table :nutrition_goals do |t|
      t.integer :calories, null: false, default: 2000
      t.integer :protein, null: false, default: 50
      t.integer :carbs, null: false, default: 300
      t.integer :total_fat, null: false, default: 65
		t.references :user, null: false, default: 0

      t.timestamps
    end
  end
end
