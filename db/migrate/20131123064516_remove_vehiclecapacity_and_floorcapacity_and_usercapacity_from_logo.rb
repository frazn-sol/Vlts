class RemoveVehiclecapacityAndFloorcapacityAndUsercapacityFromLogo < ActiveRecord::Migration
  def up
    remove_column :logos, :vehiclecapacity
        remove_column :logos, :floorcapacity
        remove_column :logos, :usercapacity
      end

  def down
    add_column :logos, :usercapacity, :string
    add_column :logos, :floorcapacity, :string
    add_column :logos, :vehiclecapacity, :string
  end
end
