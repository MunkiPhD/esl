class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name, null: false, index: true
      t.string :motto, default: ""
      t.text :description, null: false, default: ""
      t.boolean :is_public, null: false, default: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
