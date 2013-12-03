class AddUserIdToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :user_id, :integer
  end
end
