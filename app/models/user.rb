class User < ActiveRecord::Base
  has_many :wikis
  has_many :collaborators
  enum role: [:standard, :premium, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :standard
  end
  #
  # def make_standard
  #   self.role = :standard
  #   list = self.wikis
  #   list.private = false
  # end



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



end
