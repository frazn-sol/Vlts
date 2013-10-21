class AddNumberofslotsToFloor < ActiveRecord::Migration
  def change
    add_column :floors, :numberofslots, :integer
  end
end
