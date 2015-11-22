class AddTempNoteToItems < ActiveRecord::Migration
  def change
    add_column :items, :temp_note, :string, after: :note
  end
end
