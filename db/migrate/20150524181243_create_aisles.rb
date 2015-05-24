class CreateAisles < ActiveRecord::Migration
  def change
    create_table :aisles do |t|
      t.belongs_to :store, index: true, foreign_key: true
      t.string :name
      t.string :description
      t.integer :position

      t.timestamps null: false
    end
  end
end
