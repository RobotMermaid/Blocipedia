class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  protect_from_forgery with: :exception
  before_action :authenticate_user!


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


   private

   def user_not_authorized
      flash[:notice] = "I'm afraid I can't let you do that"
      redirect_to wikis_path
   end


end
