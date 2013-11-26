class Floor < ActiveRecord::Base
	audited
	has_many :vehicle_histories
  belongs_to :location
  attr_accessible :capacity, :description, :nickname, :occupied, :location_id
end
