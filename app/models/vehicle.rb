class Vehicle < ActiveRecord::Base
	belongs_to :customer
  attr_accessible :badge_number, :first_name, :last_name, :middle_name, :organization, :vehicle_name
end
