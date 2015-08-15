class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.string :class_name
      t.integer :class_id

      t.timestamps null: false
    end
  end
end
