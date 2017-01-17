class WikisController < ApplicationController


  def index
    @wikis = Wiki.all
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
    @wiki.user = current_user

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
  end


  def update
    @wiki = Wiki.find(params[:id])
    #@wiki.title = params[:wiki][:title]
    #@wiki.body = params[:wiki][:body]
    @wiki.assign_attributes(wiki_params)

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
      flash[:notice] = "The wiki:\"#{@wiki.title}\" has been deleted"
      redirect_to action: 'index'
    else
      flash[:alert] = "There was an error deleting the wiki"
      render :show
    end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
end
