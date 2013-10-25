class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :company_name
      t.string :address1
      t.string :address2
      t.string :state
      t.string :zipcode
      t.string :phone1
      t.string :phone2
      t.string :web
      t.string :email
      t.belongs_to :user

      t.timestamps
    end
  end
end
