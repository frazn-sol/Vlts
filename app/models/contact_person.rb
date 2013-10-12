class ContactPerson < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :email, :customer_id, :name, :password, :passwordhint, :phone1, :phone2, :state, :username, :website, :zipcode
  belongs_to :customer
end
