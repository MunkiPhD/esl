class CreateFavoriteFoods < ActiveRecord::Migration
  def change
    create_table :favorite_foods do |t|
      t.references :user, null: false
      t.references :food, null: false

      t.timestamps
    end
  end
end
