module WikisHelper
  def user_is_authorized_for_wikis(wiki)
    if wiki.private?
      current_user.admin? || current_user.premium?
    else
      current_user.standard? || current_user.premium? || current_user.admin?
    end
  end
end
