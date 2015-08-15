class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.string :class_name
      t.integer :class_id

      t.timestamps null: false
    end
  end
end
