class VehicleHistory < ActiveRecord::Base
	belongs_to :floor
	belongs_to :location
	belongs_to :vehicle

    attr_accessible :floor_id, :location_id, :slot, :vehicle_id, :platenumber, :flag, :parking_time, :vistor_flag, :remarks
end
