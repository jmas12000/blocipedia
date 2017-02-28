class UsersController < ApplicationController
  def downgrade
    @user = User.find(params[:id])
    @user.update_attributes(role: 'standard')
    @user_wikis = @user.wikis.where(private: true)
    
    @user_wikis.each do |user_wiki|
      user_wiki.update_attributes(private: false)
    end
     
    if @user.standard?
      flash[:notice] = "You've been downgraded to #{@user.role}. Your private wikis are now public."
      redirect_to :root
    else
      flash[:error] = "There was an error downgrading your account. Please try again."
      redirect_to :back
    end
  end
end
