class AddNameAndAddress1AndAddress2AndCityAndStateAndZipcodeAndPhone1AndPhone2AndWebsiteAndUsernameAndPasswordhintToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :name, :string
    add_column :customers, :address1, :string
    add_column :customers, :address2, :string
    add_column :customers, :city, :string
    add_column :customers, :state, :string
    add_column :customers, :zipcode, :integer
    add_column :customers, :phone1, :integer
    add_column :customers, :phone2, :integer
    add_column :customers, :website, :string
    add_column :customers, :role, :string
    add_column :customers, :username, :string
    add_column :customers, :password, :string
    add_column :customers, :passwordhint, :string
  end
end
