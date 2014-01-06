class RenameVisitorColumn < ActiveRecord::Migration
  def up
  	rename_column :vehicle_histories, :visitor, :flag
  end

  def down
  end
end
