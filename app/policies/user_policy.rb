class UserPolicy < ApplicationPolicy
  # attr_reader :user, :record

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    user == record
  end

  def edit?
    update?
  end

  def destroy?
    user == record
  end

  def feed?
    user == record
  end

  def discover?
    true
  end
  
  def view_photos?
    !record.private? || user == record || record.followers.include?(user)
  end

  def liked?   
    !record.private? || user == record || record.followers.include?(user)
  end

  class Scope < Scope
    def resolve
      scope.where(private: false).or(scope.where(id: user.leaders.pluck(:id)))
    end
  end
end
