class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.time :heure_depart
      t.time :heure_arrive
      t.integer :car_id
      t.integer :prix

      t.timestamps null: false
    end
  end
end
