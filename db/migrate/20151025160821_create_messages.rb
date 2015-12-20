class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :string
      t.string :message
      t.string :text

      t.timestamps null: false
    end
  end
end
