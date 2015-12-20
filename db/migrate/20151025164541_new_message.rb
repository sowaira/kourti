class NewMessage < ActiveRecord::Migration
  def change
    remove_column(:messages, :text, :string)
    remove_column(:messages, :string, :string)
    change_column :messages, :message,  :text
  end
end
