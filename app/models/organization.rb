class Organization < ActiveRecord::Base
  
  belongs_to :user
  has_many :organization_contacts
  has_many :vehicles
  attr_accessible :address1, :address2, :company_name, :email, :phone1, :phone2, :state, :web, :zipcode
end
