class AddDelflagToFloor < ActiveRecord::Migration
  def change
    add_column :floors, :delflag, :boolean, :default => false
  end
end
