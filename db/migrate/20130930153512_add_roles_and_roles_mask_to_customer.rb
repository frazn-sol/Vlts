class AddRolesAndRolesMaskToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :roles, :string
    add_column :customers, :roles_mask, :string
  end
end
