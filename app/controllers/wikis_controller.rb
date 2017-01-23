class WikisController < ApplicationController


  def index
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
    authorize @wiki
  end


  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    # @wiki.assign_attributes(wiki_params)

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
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "The wiki:\"#{@wiki.id}\" has been deleted"
      redirect_to action: 'index'
    else
      flash[:alert] = "There was an error deleting the wiki"
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
