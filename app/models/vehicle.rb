class Vehicle < ActiveRecord::Base
	belongs_to :oganization
  attr_accessible :badge_number, :driver_first_name, :driver_last_name, :driver_middle_name, :expiry_date, :permit_date, :platenumber, :visitor
end
