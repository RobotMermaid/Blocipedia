class WikiPolicy < ApplicationPolicy

  def show?
    if @wiki.private
      @user.role === 'premium' || @user.role === 'admin'
    else
      @user.role === 'standard' || @user.role === 'premium' || @user.role === 'admin'
    end
  end

  def index?
      @user.role === 'premium' || @user.role === 'admin'
  end


  def destroy?
    @user.role === 'admin' || @user.role === 'premium'

  end
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? || wiki.user == user 
            wikis << wiki # if the user is premium, only show them private wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private? || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users private wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
end
