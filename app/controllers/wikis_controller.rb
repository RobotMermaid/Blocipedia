class WikisController < ApplicationController
# shouldn't be able to edit someone else's wiki if not owner even tho  you are a premium user

  def index

     @wikis = policy_scope(Wiki)
     @wikis = Wiki.all.order("created_at DESC")
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new

  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to [@user, @wiki]
    else
      flash[:notice] = "There was an error. Please try again"
      render :new
    end
  end


  def edit
    @wiki = Wiki.find(params[:id])
    @collaborator_list = @wiki.collaborating_users.each do |collaborator|
      collaborator.name
     end
    authorize @wiki
  end


  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    # @wiki.assign_attributes(wiki_params)

    if current_user.admin? || current_user.premium?
      @wiki.private = params[:wiki][:private]
    end

    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:notice] = "There was an error. Please try again"
      render :edit
    end
  end



  def destroy
     @wiki = Wiki.find(params[:id])
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
   end


    def downgrade
      current_user.wikis.update_all(private: false)
      current_user.update_attributes(role: "standard")
      flash[:notice] = "You are now a standard member, #{current_user.email}!"
      redirect_to root_path
    end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
