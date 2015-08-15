class CreateTels < ActiveRecord::Migration
  def change
    create_table :tels do |t|
      t.string :number
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
