class WikiPolicy < ApplicationPolicy

   attr_reader :user, :wiki
   def initialize(user, wiki)
     @user = user
     @wiki = wiki
   end

   def show?
     @user.role === 'standard'
   end


end
