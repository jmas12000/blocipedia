class WikiPolicy < ApplicationPolicy
  
  def index?
  user.present?
  end
  
  def show?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.role == 'admin' || record.user == user
  end

  def new?
    show?
  end

  def create?
    show?
  end

  def edit?
    show?
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
          if wiki.public? || wiki.collaborators.include?(@user) || wiki.user == user
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end