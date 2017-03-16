class UsersController < ApplicationController
  
  def show
    if current_user.present?
      @user = params[:id] ? User.find(params[:id]) : current_user
    else
      redirect_to root_path
    end
  end

  def index
    @users = User.all  
  end

  def new
    @user = User.new
  end
  
  def downgrade
    @user = current_user
    @user.update_attribute(:role, "standard")
    @wikis = @user.wikis.where(user_id: @user.id).all
    
    @wikis.each do |wiki|
      wiki.update_attribute(:private, "false")
      wiki.collaborators = []
    end
    if @user
      flash[:notice] = "You've been downgraded to #{@user.role}. Your private wikis are now public."
      redirect_to :root
    else
      flash[:error] = "There was an error downgrading your account. Please try again."
      redirect_to :back
    end
  end
end

