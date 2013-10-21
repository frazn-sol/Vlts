class Floor < ActiveRecord::Base
  attr_accessible :description, :name, :numberofslots, :plaza_id
  belongs_to :plaza
end
