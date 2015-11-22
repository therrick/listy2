class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :component, index: true, foreign_key: true
      t.references :calendar, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end