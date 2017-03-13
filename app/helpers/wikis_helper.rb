module WikisHelper
  def authorized_collaborators?(wiki)
    wiki.collaborators.include?(current_user) || current_user.admin? || current_user.id == wiki.user_id
  end
  
  def owner_of_wiki?(wiki)
    current_user.admin? || current_user.id == @wiki.user_id
  end
end
