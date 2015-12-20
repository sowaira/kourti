class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.string :class_name
      t.integer :object_id
      t.integer :type_action

      t.timestamps null: false
    end
  end
end
