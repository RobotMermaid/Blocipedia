class Wiki < ActiveRecord::Base
  belongs_to :user
  # 
  # def make_public
  #   # all user's wikis .private = false
  #   self.private = false
  # end
    #  scope :visible_to, -> (user) { user && user.standard? ? where(private: false) : all }
end
