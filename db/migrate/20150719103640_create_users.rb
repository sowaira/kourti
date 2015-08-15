class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password
      t.integer :type_user
      t.text :adresse

      t.timestamps null: false
    end
  end
end
