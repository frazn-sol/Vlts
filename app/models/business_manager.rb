class BusinessManager < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :email, :name, :password, :passwordhint, :phone1, :phone2, :role, :state, :username, :website, :zipcode
  belongs_to :admin
end
