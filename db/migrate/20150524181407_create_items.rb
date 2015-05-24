class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :store, index: true, foreign_key: true
      t.belongs_to :aisle, index: true, foreign_key: true
      t.string :name
      t.string :notes
      t.integer :number_needed, default: 0
      t.integer :popularity, default: 0

      t.timestamps null: false
    end
  end
end
