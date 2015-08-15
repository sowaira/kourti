class AddUserToCar < ActiveRecord::Migration
  def change
  	add_column :cars, :user_id, :integer
  end
end
