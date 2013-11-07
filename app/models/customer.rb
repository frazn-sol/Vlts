class Customer < ActiveRecord::Base
  has_one :user
  belongs_to :user
  has_many :customer_contacts
  attr_accessible :address1, :address2, :company_name, :phone1, :phone2, :state, :web, :zipcode, :user_attributes, :created_at, :user_id
end
