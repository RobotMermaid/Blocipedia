class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :collaborating_users, through: :collaborators, source: :user

  # before_create :make_public
  # def make_public
  #   if self.public.nil?
  #     self.public = true
  #   end
  # end
    #  scope :visible_to, -> (user) { user && user.standard? ? where(private: false) : all }
end
