class RemoveRoleFromCustomer < ActiveRecord::Migration
  def up
    remove_column :customers, :role
      end

  def down
    add_column :customers, :role, :string
  end
end
