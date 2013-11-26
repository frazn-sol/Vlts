class AddDelflagToOrganizationContact < ActiveRecord::Migration
  def change
    add_column :organization_contacts, :delflag, :boolean, :default => false
  end
end
