class CreateOrganizationContacts < ActiveRecord::Migration
  def change
    create_table :organization_contacts do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :designation
      t.string :phone
      t.string :cell
      t.string :email
      t.belongs_to :organization

      t.timestamps
    end
  end
end
