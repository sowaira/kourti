class CreateVilles < ActiveRecord::Migration
  def change
    create_table :villes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
