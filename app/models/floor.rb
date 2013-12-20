class Floor < ActiveRecord::Base
	audited
	has_many :vehicle_histories
  belongs_to :location
  attr_accessible :capacity, :description, :nickname, :occupied, :location_id, :user_id
  attr_accessor :loc_id
end
