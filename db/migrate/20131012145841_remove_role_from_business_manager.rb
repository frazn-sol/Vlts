class RemoveRoleFromBusinessManager < ActiveRecord::Migration
  def up
    remove_column :business_managers, :role
      end

  def down
    add_column :business_managers, :role, :string
  end
end
