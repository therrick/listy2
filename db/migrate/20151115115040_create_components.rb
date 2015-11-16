class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name, index: true
      t.string :link
      t.text :note

      t.timestamps null: false
    end
  end
end
