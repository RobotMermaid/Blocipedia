class CollaboratorsController < ApplicationController



  def new
    @user = User.all
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    @collaborator = @wiki.collaborators.build(user: @user)

    if @collaborator.save
      flash[:notice] = "You added #{@user.name} as a collaborator to your wiki."
      redirect_to action: 'new'
    else
      flash[:error] = "There was an error adding this collaborator. Please try again."
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:id])
    # the specific number of collaborators id works  @wiki.collaborator.find(230)
    # this removes the user all together User.find(@user)
    # now it removes the collaborator by collaborator id not user_id Collaborator.find(@user.id)
    @collaborator = @wiki.collaborators.find_by_user_id(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator #{@user.name} removed from wiki."
      redirect_to action: 'new'
    else
      flash[:error] = "There was an error deleting this collaborator. Please try again."
      redirect_to action: 'new'
    end
  end





end
