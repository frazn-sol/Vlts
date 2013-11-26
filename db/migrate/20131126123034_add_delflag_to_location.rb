class AddDelflagToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :delflag, :boolean, :default => false
  end
end
