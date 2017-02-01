class UsersController < ApplicationController

  def index
    @users = User.all
    @user=current_user
    # @wiki = @user.wikis
    # @owner = current_user.wiki
  end


end
