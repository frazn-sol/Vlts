class AddPassChangeToUser < ActiveRecord::Migration
  def change
    add_column :users, :pass_change, :boolean, :default => false
  end
end
