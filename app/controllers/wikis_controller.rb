class WikisController < ApplicationController
  include ApplicationHelper
  
  before_action :authenticate_user!
  
  def index
    @wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create
    @user = current_user
    @wiki = @user.wikis.build(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki titled #{@wiki.title} was saved."
      redirect_to @wiki
    else
      flash.now[:error] = "There was an error saving the wiki titled #{@wiki.title}. Please try again."
      render :new
    end
  end

  def edit
    @users = User.all
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def update 
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.user_ids = params[:wiki][:user_ids] if params[:wiki][:user_ids].present?
 
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki titled #{@wiki.title} was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki titled #{@wiki.title}. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
 
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:error] = "There was an error deleting the wiki titled \"#{@wiki.title}\"."
      render :show
    end
  end
  
  def create_collaborator
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    
    if @user
      @wiki.collaborators << (@user)
      flash[:notice] = "#{@user.email} successfully added as collaborator to wiki."
      redirect_to @wiki 
    else
      flash[:error] = "There was an error adding #{@user.email} as collaborator to wiki."
      redirect_to :edit
    end  
  end
  
  def destroy_collaborator
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find( params[:user_id])
    @collaborator = @wiki.collaborators.find(@user.id)
    
    if @collaborator 
      @wiki.collaborators.destroy(@collaborator)
      flash[:notice] = "#{@user.email} was successfully removed as collaborator to wiki."
      redirect_to @wiki
    else
      flash[:error] = "Error. Could not remove #{@user.email} as collaborator to wiki."
      redirect_to @wiki
    end 
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:id, :title, :body, :user_id, :private)
  end
end
