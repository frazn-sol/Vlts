class RemoveVisitorFromVehicle < ActiveRecord::Migration
  def up
    remove_column :vehicles, :visitor
      end

  def down
    add_column :vehicles, :visitor, :boolean
  end
end
