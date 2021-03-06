class User < ActiveRecord::Base
  audited
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :children, class_name: "User", foreign_key: "parent_id"
  belongs_to :parent, class_name: "User"

  belongs_to :customer
  has_many :customers

  has_many :organizations
  has_many :locations
  has_many :system_configs

  # Setup accessible (or protected) attributes for your model
  attr_accessor :try, :forgot
  attr_accessible :email, :password, :password_confirmation, :remember_me, :created_at, :parent_id, :password
  attr_accessible :id, :cell, :first_name, :last_name, :middle_name, :phone, :role, :passwordhint, :employeeno, :parent_id, :pass_change
  

  
  def self.find_for_authentication(conditions)
    super(conditions.merge(:delflag => false))
  end

end
