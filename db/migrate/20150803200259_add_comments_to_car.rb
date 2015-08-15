class AddCommentsToCar < ActiveRecord::Migration
  def change
    add_column :cars, :car_id, :integer
  end
end
