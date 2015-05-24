class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :name
      t.boolean :hidden, null: false, default: false

      t.timestamps null: false
    end
  end
end
