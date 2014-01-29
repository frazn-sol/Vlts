class Message
include ActiveAttr::Model
  
  attribute :first_name
  attribute :last_name
  attribute :phone
  attribute :email
  attribute :content
  
  validates_presence_of :first_name
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :content, :maximum => 500

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
