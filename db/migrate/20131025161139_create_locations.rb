class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :nickname
      t.string :description
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
