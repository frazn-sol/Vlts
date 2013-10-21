class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
      t.string :name
      t.string :companyname
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zipcode
      t.integer :phone1
      t.integer :phone2
      t.string :website
      t.string :email
      t.string :role
      t.string :username
      t.string :password
      t.string :passwordhint
      t.belongs_to :customer

      t.timestamps
    end
  end
end
