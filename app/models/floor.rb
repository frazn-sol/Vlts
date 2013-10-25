class Floor < ActiveRecord::Base
  belongs_to :location
  attr_accessible :capacity, :description, :nickname, :occupied, :location_id
end
