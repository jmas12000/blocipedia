class User < ActiveRecord::Base
  has_many :wikis
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:email]
         
  
  accepts_nested_attributes_for :wikis
  after_initialize :set_default_role, :if => :new_record?
  
  enum role: [:standard, :admin, :premium]

  def set_default_role
    self.role ||= :standard
  end
         
         
  
 
end
