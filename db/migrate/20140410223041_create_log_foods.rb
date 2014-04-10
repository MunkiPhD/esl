class CreateLogFoods < ActiveRecord::Migration
  def change
    create_table :log_foods do |t|
      t.decimal :servings, :null => false, :default => 1
      t.date :log_date, :null => false, :default => Date.today
      t.references :food, :null => false
      t.references :user, :null => false


      t.timestamps
    end
  end
end
