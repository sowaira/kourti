class AddTokensToTables < ActiveRecord::Migration
  def change
  	add_column :cars, :token, :string
  	add_column :lines, :token, :string
  	add_column :escales, :token, :string
  end
end
