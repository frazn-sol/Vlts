class Vehicle < ActiveRecord::Base
	audited
	belongs_to :organization
	has_many :vehicle_histories
  attr_accessible :badge_number, :driver_first_name, :driver_last_name, :driver_middle_name, :expiry_date, :permit_date, :platenumber, :visitor, :organization_id, :colour, :make, :model
end
