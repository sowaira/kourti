class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :link
      t.string :class_name
      t.integer :object_id
      t.integer :image_type

      t.timestamps null: false
    end
  end
end
