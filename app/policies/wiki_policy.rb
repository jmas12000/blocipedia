class WikiPolicy < ApplicationPolicy
  
  def index?
  user.present?
  end
  
  def show?
   record.public? || user.role == 'admin' || (user.role == 'premium' && record.user == user) || record.collaborators.include?(user)#user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.role == 'admin' || record.user == user
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.role == 'admin' || record.user == user || record.collaborators.include?(user)
  end

  class Scope
    attr_reader :user, :scope
 
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
 
    def resolve
      wikis = []

      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || user.role == 'admin' || (user.role == 'premium' && wiki.user == user) || wiki.collaborators.include?(user) 
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user) || wiki.user_id == user.id
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end