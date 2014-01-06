class AddUserIdToVehicleHistory < ActiveRecord::Migration
  def change
    add_column :vehicle_histories, :user_id, :integer
  end
end
