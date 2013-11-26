class AddDelflagToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :delflag, :boolean, :default => false
  end
end
