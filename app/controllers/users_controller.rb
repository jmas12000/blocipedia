class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :new]
  
  def index
    @users = User.all
  end
  
  def show

  end
  
  def new
  
  def edit

  end
  
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
end
