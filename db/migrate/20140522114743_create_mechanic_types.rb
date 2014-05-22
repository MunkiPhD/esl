class CreateMechanicTypes < ActiveRecord::Migration
  def change
    create_table :mechanic_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
