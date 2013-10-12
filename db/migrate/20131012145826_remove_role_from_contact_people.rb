class RemoveRoleFromContactPeople < ActiveRecord::Migration
  def up
    remove_column :contact_people, :role
      end

  def down
    add_column :contact_people, :role, :string
  end
end
