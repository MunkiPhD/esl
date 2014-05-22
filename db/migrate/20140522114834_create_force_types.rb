class CreateForceTypes < ActiveRecord::Migration
  def change
    create_table :force_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
