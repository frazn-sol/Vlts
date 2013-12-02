class AddUserIdToFloor < ActiveRecord::Migration
  def change
    add_column :floors, :user_id, :integer
  end
end
