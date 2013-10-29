class Location < ActiveRecord::Base
  has_many :floors
  belongs_to :user
  has_many :vehicle_histories
  attr_accessible :address1, :address2, :description, :email, :nickname, :phone1, :phone2, :state, :web, :zipcode
end
