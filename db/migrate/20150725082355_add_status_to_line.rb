class AddStatusToLine < ActiveRecord::Migration
  def change
  	add_column :lines, :status, :integer
  end
end
