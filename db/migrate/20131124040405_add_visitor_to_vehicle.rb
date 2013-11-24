class AddVisitorToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :visitor, :string
  end
end
