class CreateBusinessManagers < ActiveRecord::Migration
  def change
    create_table :business_managers do |t|
      t.string :name
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

      t.timestamps
    end
  end
end
