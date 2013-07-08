class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, :default => ''
      t.string :brand, :default => ''
      t.string :ndb_no, :limit => 6, :default => ''
      t.text :ingredients, :default => ''
      t.boolean :usda, :default => false
      t.string :serving_size, :null => false, :default => '1 serving'
      t.integer :calories, :null => false, :default => 0
      t.integer :calories_from_fat, :null => false, :default => 0
      t.decimal :total_fat, :null => false, :default => 0
      t.decimal :saturated_fat, :null => false, :default => 0
      t.decimal :trans_fat, :null => false, :default => 0
      t.decimal :polyunsaturated_fat, :null => false, :default => 0
      t.decimal :monounsaturated_fat, :null => false, :default => 0
      t.decimal :cholesterol, :null => false, :default => 0
      t.decimal :sodium, :null => false, :default => 0
      t.decimal :carbs, :null => false, :default => 0
      t.decimal :dietary_fiber, :null => false, :default => 0
      t.decimal :sugars, :null => false, :default => 0
      t.decimal :protein, :null => false, :default => 0
      t.integer :vitamin_a, :null => false, :default => 0
      t.integer :vitamin_c, :null => false, :default => 0
      t.integer :calcium, :null => false, :default => 0
      t.integer :iron, :null => false, :default => 0
      t.integer :vitamin_d, :null => false, :default => 0
      t.integer :vitamin_e, :null => false, :default => 0
      t.integer :vitamin_k, :null => false, :default => 0
      t.integer :thiamin, :null => false, :default => 0
      t.integer :riboflavin, :null => false, :default => 0
      t.integer :niacin, :null => false, :default => 0
      t.integer :vitamin_b6, :null => false, :default => 0
      t.integer :biotin, :null => false, :default => 0
      t.integer :pantothenic_acid, :null => false, :default => 0
      t.integer :phosphorus, :null => false, :default => 0
      t.integer :iodine, :null => false, :default => 0
      t.integer :magnesium, :null => false, :default => 0
      t.integer :zinc, :null => false, :default => 0
      t.integer :selenium, :null => false, :default => 0
      t.integer :copper, :null => false, :default => 0
      t.integer :manganese, :null => false, :default => 0
      t.integer :chromium, :null => false, :default => 0
      t.integer :molybednum, :null => false, :default => 0
      t.integer :caffeine, :null => false, :default => 0
      t.integer :alcohol, :null => false, :default => 0
      t.decimal :potassium, :null => false, :default => '0'
      t.integer :folic_acid, :null => false, :default => '0'
      t.decimal :boron, :decimal, :null => false, :default => '0'
      t.decimal :cobalt, :null => false, :default => '0'
      t.decimal :chloride, :null => false, :default => '0'
      t.decimal :fluoride, :null => false, :default => '0'
      t.decimal :acetic_acid, :null => false, :default => '0'
      t.decimal :citric_acid, :null => false, :default => '0'
      t.decimal :lactic_acid, :null => false, :default => '0'
      t.decimal :malic_acid, :decimal, :null => false, :default => '0'
      t.decimal :choline, :null => false, :default => '0'
      t.decimal :taurine, :null => false, :default => '0'
      t.decimal :glutamine, :null => false, :default => '0'
      t.decimal :creatine, :null => false, :default => '0'
      t.decimal :sugar_alcohols, :null => false, :default => '0'

      t.timestamps
    end
  end
end
