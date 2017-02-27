class UsersController < ApplicationController
  
  def downgrade
    @user = current_user
    @user.update_attributes(role: 'standard')
 
    if @user.standard?
      flash[:notice] = "You've been downgraded to #{@user.role}. Your private wikis are now public."
      redirect_to :root
    else
      flash[:error] = "There was an error downgrading your account. Please try again."
      redirect_to :back
    end
  end
end
