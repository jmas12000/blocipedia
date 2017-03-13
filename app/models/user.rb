class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:email]
         
  has_many :collaborations
  has_many :collaborating_wikis, through: :collaborations, source: :wiki
  has_many :wikis  
  
  after_initialize :set_default_role, :if => :new_record?
  enum role: [:standard, :admin, :premium]

  private
  
  def set_default_role
    self.role ||= :standard
  end
end
