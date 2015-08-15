class CreateEscales < ActiveRecord::Migration
  def change
    create_table :escales do |t|
      t.integer :ville_id
      t.integer :order_escale
      t.string :line_id

      t.timestamps null: false
    end
  end
end
