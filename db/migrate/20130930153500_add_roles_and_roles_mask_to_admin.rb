class AddRolesAndRolesMaskToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :roles, :string
    add_column :admins, :roles_mask, :string
  end
end
