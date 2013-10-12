class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable

  belongs_to :admin
  belongs_to :business_manager
  has_many :contact_persons
  has_many :plazas
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :address1, :address2,
                  :city, :state, :zipcode, :phone1, :phone2, :website, :username, :passwordhint
  # attr_accessible :title, :body
  attr_accessor :contact_person
end
