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
    @user.role === 'admin'
  end

end
